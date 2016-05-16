package com.manager
{
	import com.data.HashMap;
	import com.event.TEvent;
	import com.web.WebActiveInfo;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 *  HTTP管理器，负责通信和基础的数据解析
	 * @author tomatolyf
	 * (弄清楚 URLLoader的所有属性)
	 * 
	 */
	public class HttpManager
	{
		private static var _instance : HttpManager;
		
		public static function get instance():HttpManager
		{
			if(_instance == null)
			{
				_instance = new HttpManager();
			}
			return _instance;
		}
		
		private var _urlLoader : URLLoader;
		private var _sequenceList : Array;
		private var _isLoading : Boolean = false;
		
		public function HttpManager()
		{
			_sequenceList = new Array();
			_isLoading = false;
			initLoader();
		}
		
		private function initLoader():void
		{
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE,onLoadComplete);
		}
		
		private function onLoadComplete(e : Event):void
		{
			var data : * = _urlLoader.data;
			var info : WebActiveInfo = _sequenceList.shift();
			if(info.callBack != null)
			{
				info.callBack(data);
			}else
			{
				EventManager.dispatchEvent(new TEvent(info.URL,data));
			}
			_isLoading = false;
			if(_sequenceList.length > 0)
			{
				doLoad();
			}
		}
		
		private function doLoad():void
		{
			var info : WebActiveInfo = _sequenceList[0];
			if(info)
			{
				_isLoading = true;
				_urlLoader.load(new URLRequest(info.URL));
			}
		}
		
		public function load(url : String, callBack : Function , ... args):void
		{
			//是否需要数据拼接 , 序列化 , 回调
			var info : WebActiveInfo = new WebActiveInfo();
			info.URL = url;
			info.callBack = callBack;
			info.args = args;
			_sequenceList.push(info);
			if(!_isLoading)
			{
				doLoad();
			}
		}
		
	}
}