# `GOOGLE-CHROME`

https://wiki.nixos.org/wiki/Default_applications

https://mail.bana.io/mail/u/1/#inbox
navigator.registerProtocolHandler("mailto", "https://mail.bana.io/mail/?extsrc=mailto&url=%s", "mail.bana.io");
navigator.registerProtocolHandler("mailto", "https://mail.google.com/mail/u/1/?extsrc=mailto&url=%s", "mail.bana.io");

```sh
sudo mkdir -vp /etc/opt/chrome/policies
sudo mkdir -vp /etc/opt/chrome/policies/managed
sudo mkdir -vp /etc/opt/chrome/policies/recommended
sudo chmod -v -w /etc/opt/chrome/policies/managed
sudo tee /etc/opt/chrome/policies/managed/bana-io_policy.json <<EOF
{

    "RegisteredProtocolHandlers": [
        {
            "default": true,
            "protocol": "mailto",
            "url": "https://mail.google.com/mail/u/1?extsrc=mailto&url=%s"
        }
    ],
    "ExternalProtocolDialogShowAlwaysOpenCheckbox": true,
    "RestoreOnStartup": 1,
    "ShowHomeButton": true
}
EOF
```
