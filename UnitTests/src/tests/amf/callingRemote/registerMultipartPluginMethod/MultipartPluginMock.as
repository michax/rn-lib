/***************************************************************************************************
 * Copyright (c) 2014. Rafał Nagrodzki (e-mail: rafal[at]nagrodzki.net)
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

/**
 * @author Rafał Nagrodzki (e-mail: rafal@nagrodzki.net)
 */
package tests.amf.callingRemote.registerMultipartPluginMethod
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import rnlib.net.plugins.INetMultipartPlugin;
	import rnlib.net.plugins.INetPluginVO;

	public class MultipartPluginMock extends EventDispatcher implements INetMultipartPlugin
	{
		[ArrayElementType("tests.amf.callingRemote.registerMultipartPluginMethod.MultipartPluginMockSequenceVO")]
		public var eventsSequence:Array;

		public function MultipartPluginMock()
		{

		}


		public function nextFromSequence():void
		{
			var vo:MultipartPluginMockSequenceVO = eventsSequence.shift();

			if(vo.exception && vo.beforeEvent)
				throw vo.exception;

			dispatchEvent(vo.event);

			if(vo.exception && !vo.beforeEvent)
				throw vo.exception;
		}

		public function onResult(result:Object):void
		{
			nextFromSequence();
		}

		public function onFault(fault:Object):void
		{
			nextFromSequence();
		}

		public function init(vo:INetPluginVO):void
		{
			if(vo is MultipartPluginMockVO)
				eventsSequence = MultipartPluginMockVO(vo).eventsSequence;

			nextFromSequence();
		}

		public function dispose():void
		{
		}

		public function get args():Array
		{
			return null;
		}

		public function get dispatcher():IEventDispatcher
		{
			return null;
		}

		public function set dispatcher(value:IEventDispatcher):void
		{
		}
	}
}
