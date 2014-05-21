/**
 * @author Rafał Nagrodzki (e-mail: rafal@nagrodzki.net)
 */
package tests.amf.callingRemote.registerMethod
{
	import tests.amf.callingRemote.registerMethod.CallRemoteRegisteredMethodFinishedWithFault;
	import tests.amf.callingRemote.registerMethod.CallRemoteRegisteredMethodFinishedWithResult;

	[Suite(order="1")]
	[RunWith("org.flexunit.runners.Suite")]
	public class RegisterMethod
	{
		public var returningResult:CallRemoteRegisteredMethodFinishedWithResult;
		public var returningFault:CallRemoteRegisteredMethodFinishedWithFault;

	}
}
