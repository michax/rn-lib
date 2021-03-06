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
package rnlib.net.plugins.examples
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;

	import rnlib.interfaces.IDisposable;
	import rnlib.net.plugins.INetPlugin;
	import rnlib.net.plugins.INetPluginOwner;
	import rnlib.net.plugins.INetPluginVO;
	import rnlib.net.plugins.PluginRequestVO;

	public class MultipartFilePlugin extends EventDispatcher implements INetPlugin, IDisposable
	{
		protected var _vo:FileReferencePluginVO;
		protected var _owner:INetPluginOwner;

		public function MultipartFilePlugin()
		{
		}

		public static const CHUNK_SIZE:uint = 100 * 1024; //100KB

		private var _filePos:uint = 0;

		protected function getNextFilePart():void
		{
			var ba:ByteArray = new ByteArray();
			_vo.fileReference.data.position = _filePos;
			ba.readBytes(_vo.fileReference.data, _filePos,
						 _filePos + CHUNK_SIZE > _vo.fileReference.data.length ?
						 _vo.fileReference.data.length - _filePos : CHUNK_SIZE);
			_vo.args[0] = ba;
			_filePos += CHUNK_SIZE;
		}

		public function onResult(result:Object):void
		{
			// if file was upload we send plugin complete event
			if (_filePos >= _vo.fileReference.data.length)
				_owner.pluginRisesComplete(this);
			else
			{

			}
		}

		public function onFault(fault:Object):void
		{
			_owner.pluginRisesFault(this, fault);
		}

		public function init(owner:INetPluginOwner, vo:INetPluginVO):void
		{
			_owner = owner;
			_vo = vo as FileReferencePluginVO;

			if (!_vo.fileReference.data)
			{
				_vo.fileReference.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
				_vo.fileReference.load();
			}
			else
			{
				getNextFilePart();
				_owner.pluginRequest(this, new PluginRequestVO(null));
			}
		}

		private function onComplete(e:Event):void
		{
			getNextFilePart();
			_owner.pluginRequest(this, new PluginRequestVO(null));
		}

		public function dispose():void
		{
			_vo = null;
		}
	}
}
