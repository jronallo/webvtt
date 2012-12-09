# WEBVTT FILE parser for Ruby

Parse WebVTT files with Ruby.
The main goal is just to extract the text out with start and end times.
The parsing does not conform the [WebVTT specification](http://dev.w3.org/html5/webvtt/) at this point.


# Story

We were creating WebVTT files to enable closed captions for HTML5 video.
We wanted to reuse this work to embed the transcript in the video player
page to increase SEO and allow for jumping to sections of the video.

# Install

```
gem install webvtt
```

# Usage

Based on this WebVTT:

```
WEBVTT

1
00:00:00 --> 00:00:03.000 D:vertical A:start
I grew up in Eastern North Carolina, <b>Edgecombe</b> County

2
00:00:03.300 --> 00:00:07.800 A:start
on a tobacco and dairy farm outside of Tarboro.
```

You can do the following:


```
require 'webvtt'
vtt = Webvtt::File.new('path/to/file.vtt')
vtt.cues.class    #=> Webvtt::Cue
vtt.cues[0].start #=> '00:00:00'
vtt.cues[0].end   #=> '00:00:03.000'
vtt.cues[0].identifier #=> '1'
vtt.cues[0].settings   #=> 'D:vertical A:start'
vtt.cues[0].text       #=> 'I grew up in Eastern North Carolina, <b>Edgecombe</b> County'
```

# Author

Jason Ronallo

# License

See LICENSE
