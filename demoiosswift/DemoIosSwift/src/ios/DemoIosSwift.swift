import IonicBridge
@objc(DemoIosSwift) class DemoIosSwift : CDVPlugin {
    var listenerCallbackId: String?
  @objc(echo:)
  func echo(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        let msg = command.arguments[0] as? String ?? ""

        if !msg.isEmpty {
            let toastController: UIAlertController =
                UIAlertController(
                    title: "",
                    message: msg,
                    preferredStyle: .alert
            )

            self.viewController?.present(
  toastController,
  animated: true,
  completion: nil
)

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                toastController.dismiss(
                    animated: true,
                    completion: nil
                )
            }

            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: msg
            )
        }

        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }

  func actionBindListener(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        self.listenerCallbackId = command.callbackId

        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        pluginResult?.setKeepCallbackAs(true)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    func reportEvent(eventData: [AnyHashable : Any]) {
        print("reportEvent...")
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: eventData)
        pluginResult?.setKeepCallbackAs(true)
        self.commandDelegate.send(pluginResult, callbackId: self.listenerCallbackId)

    }

func callFromIonic(command: CDVInvokedUrlCommand) {
        let param = command.arguments[0] as? String ?? "no param found"
        var pluginResult: CDVPluginResult?

        do {
            try IonicBridge.callFromIonic(someparams: param)
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        }
        catch {
            pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
        }
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

}
