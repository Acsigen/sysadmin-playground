# Echo cancellation

## Prerequisites

Enable echo cancellation in Linux using PulseAudio.

## Enable on startup

Edit `/etc/pulse/default.pa`, scroll down to the end of the file and add the following code:

```conf
.ifexists module-echo-cancel.so
load-module module-echo-cancel aec_method=webrtc source_name=echocancel sink_name=echocancel1
set-default-source echocancel
set-default-sink echocancel1
.endif
```

What it does: if your system PulseAudio is compiled with the echo / noise cancellation module, load this module, use webrtc as the echo cancellation method, specify a source and sink names, then set that source and sink as default.

Save the file and reload PulseAudio using `pulseaudio -k`.

You should now have two options in sound settings, one of them with _echo cancelled_ surrounded by parentheses.

## Enable on demand

Place the following script in a file and run it when you need it:

```bash
pactl unload-module module-echo-cancel
pactl load-module module-echo-cancel aec_method=webrtc source_name=echocancel sink_name=echocancel1
pacmd set-default-source echocancel
pacmd set-default-sink echocancel1
```

You can also create a launcher by creating a file called `echocancel.desktop` in `~/.local/share/applications/`:

```conf
[Desktop Entry]
Version=1.0
Name=Echo Cancel PulseAudio Module
Comment=Load the PulseAudio module-echo-cancel
Exec=echocancel
Icon=multimedia-volume-control
Type=Application
Categories=AudioVideo;Audio;
```

In case you want to unload the module: `pactl unload-module module-echo-cancel`

## Multiple microphones

This sections helps you configure echo cancellation when you have multiple microphones connected.

First, you need to list the available microphones using `LANG=C pacmd list-sources | grep name:`

My output looks like this:

```output
name: <alsa_output.pci-0000_00_1b.0.analog-stereo.monitor>
name: <alsa_input.pci-0000_00_1b.0.analog-stereo>
name: <alsa_input.usb-046d_HD_Pro_Webcam_C920_193F65AF-02.analog-stereo>
```

As you can see, I have the default microphone of the laptop and another one provided by the webcam.

Now that you have the names, the only thing you need to do is to add `source_master=alsa_input.usb-046d_HD_Pro_Webcam_C920_193F65AF-02.analog-stereo` to the commands above.

As an example, the new ondemand script looks like this:

```bash
pactl unload-module module-echo-cancel
pactl load-module module-echo-cancel source_master=alsa_input.usb-046d_HD_Pro_Webcam_C920_193F65AF-02.analog-stereo aec_method=webrtc source_name=echocancel sink_namFe=echocancel1
pacmd set-default-source echocancel
pacmd set-default-sink echocancel1
```

## Source

- [LinuxUprising.com](https://www.linuxuprising.com/2020/09/how-to-enable-echo-noise-cancellation.html)
- [Module documentation](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-echo-cancel)
