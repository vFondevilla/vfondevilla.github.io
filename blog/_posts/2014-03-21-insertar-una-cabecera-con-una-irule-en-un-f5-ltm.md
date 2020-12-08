---
layout: post
title: Insertar una cabecera con una iRule en un F5 LTM
date: 2014-03-21 17:32
author: victor
comments: true
categories: [devops, f5, ltm]
---
Entre otras cosas que gestiono, me ha tocado insertar cabeceras en peticiones HTTP que pasan por un F5 LTM... Siendo de lo más simple mediante iRules:
<em>when HTTP_REQUEST {</em>
<em>HTTP::header insert cabecera valor</em>
<em> log local0. "iRule x-secure" </em>
<em> log local0. "[HTTP::request]" </em>
<em> log local0. "Fin iRule x-secure" </em>
<em>}</em>
