---
layout: post
title: Set all databases simple recovery mode
date: 2014-07-25 11:26
author: victor
comments: true
categories: [Uncategorized]
---
<pre class="prettyprint lang-sql prettyprinted" style="color: black;"><span class="kwd" style="color: #0000ff;">select</span><span class="str" style="color: #ff0000;">'alter database ['</span><span class="pun" style="color: #808080;">+</span><span class="pln">name</span><span class="pun" style="color: #808080;">+</span><span class="str" style="color: #ff0000;">'] set recovery simple'</span><span class="kwd" style="color: #0000ff;">from</span><span class="pln"> master</span><span class="pun" style="color: #808080;">.</span><span class="pln">sys</span><span class="pun" style="color: #808080;">.</span><span class="pln">databases </span><span class="kwd" style="color: #0000ff;">where</span><span class="pln"> database_id &gt; 4 </span><span class="kwd3" style="color: #808080;">and</span><span class="pln"> state_desc </span><span class="pun" style="color: #808080;">=</span><span class="str" style="color: #ff0000;">'online'</span></pre>
