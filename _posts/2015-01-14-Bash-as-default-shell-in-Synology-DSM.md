---
layout: post
title: Bash as default shell in Synology DSM
---

It's so simple... You only have to edit /root/.profile and add the following:
{% highlight bash %}
if [[ -x /usr/syno/synoha/bin/bash ]]; then
        exec /usr/syno/synoha/bin/bash
fi
{% endhighlight %}