/***************************************************************************************************
 * Copyright (c) 2013. Rafał Nagrodzki (e-mail: rafal[at]nagrodzki.net)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR
 * A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 **************************************************************************************************/
package rnlib.net.service.connections
{
	import flash.events.IEventDispatcher;

	import rnlib.interfaces.IDisposable;

	/**
	 * Interface for api consistency between all connection implementations.
	 */
	public interface IConnection extends IEventDispatcher, IDisposable
	{
		//---------------------------------------------------------------
		//              <------ CONNECTION ------>
		//---------------------------------------------------------------

		function connect(uri:String):void;

		function close():void;

		function get connected():Boolean;

		function call(command:String, result:Function = null, fault:Function = null, ...args):void;

		//---------------------------------------------------------------
		//              <------ RECONNECT REPEAT COUNT ------>
		//---------------------------------------------------------------

		function get reconnectRepeatCount():uint;

		function set reconnectRepeatCount(value:uint):void;

		//---------------------------------------------------------------
		//              <------ CLIENT ------>
		//---------------------------------------------------------------

		function get client():Object;

		function set client(value:Object):void;

		//---------------------------------------------------------------
		//              <------ HEADERS ------>
		//---------------------------------------------------------------

		function addHeader(name:String, mustUnderstand:Boolean = false, data:* = undefined):void;

		function removeHeader(name:String):Boolean;

		//---------------------------------------------------------------
		//              <------ OBJECT ENCODING ------>
		//---------------------------------------------------------------

		function get objectEncoding():uint;

		function set objectEncoding(value:uint):void;

		//---------------------------------------------------------------
		//              <------ REDISPATCHER ------>
		//---------------------------------------------------------------

		function get redispatcher():IEventDispatcher;

		function set redispatcher(value:IEventDispatcher):void;

		//---------------------------------------------------------------
		//              <------ KEEP ALIVE ------>
		//---------------------------------------------------------------

		function get keepAliveTime():int;

		function set keepAliveTime(value:int):void;
	}
}
