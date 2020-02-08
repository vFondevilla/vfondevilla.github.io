---
layout: post
title: Sobre la blameless culture
---
## O notas realistas sobre alguien que está en proceso de implementarlo.
Como todas las cosas de este mundillo, se pasa por un momento, el momento del hype, que implica que todo el mundo quiere implementar/usar una cosa, pero sin terminar de entender sus implicaciones o su potencialidad completa. Buzzwords al poder.

En este caso, desde hace algún tiempo, ha pasado con la blameless culture.

Y qué es la blameless culture? Pero creo que antes, deberíamos poner nombre a las formas actuales de actuación.

Las formas típicas de hacer las cosas, donde los Root Cause Analysis se centran más en encontrar un culpable último, generalmente un humano o un proveedor externo.

Esta forma de operar, que podríamos llegar a considerarla “blameful”, castiga los errores individuales, provocando que los individuos y equipos intenten a toca costa ocultar los errores de la organización, por temor a las reprimendas o ser “humillados” públicamente. ¿Os suena? Seguro que sí.

La blameless culture es un cambio organizacional y metodológico donde los fallos no se ven como algo inherentemente malo, si no como oportunidades para analizar en detalle las flaquezas de los procesos y de la organización.

¿Qué quiero decir con que es un cambio organizacional y metodológico? Básicamente, es un cambio que no implica decisiones técnicas ni nuevas herramientas, ni nuevos paradigmas de programación. Aunque podría llevar a la implementación de nuevas herramientas dentro de la organización.

### Blameless culture 101

Las características básicas de una cultura “blameless” se pueden resumir en:

* Asumir en que todo el mundo de la organización lo están haciendo lo mejor posible con la información y circunstancias que en ese momento conforman su realidad.

* Ser transparente en la comunicación, siendo asertivo y profesional. Esto, en mi opinión debería basarse en canales de comunicación públicos dentro de la organización, donde todo el mundo pueda evaluar la información y ofrecer una opinión profesional.

* Crear un entorno donde las personas individuales puedan expresar porqué algo en un momento determinado tenía sentido, sin miedo a ser juzgados. Esto terminaría provocando lo que se define como “Psychological Safety”

* El error humano es un efecto de una deficiencia sistémica de la organización. Hay que centrarse en el proceso u organización más que en la persona.

* Siempre hay que intentar llegar a la raíz del problema. Como recomendación, usaría el método de los “5 Por qué”. Básicamente, desde un motivo superficial, preguntándonos 5 veces por qué es muy probable que lleguemos a un motivo raíz que no será “Error humano”.

* Asumir que las organizaciones solo pueden mejorar si están continuamente buscando las ineficiencias o equivocaciones. ¿Y quién mejor para describir esas cosas que la persona que cometió el error?

Una de mis frases favoritas dentro de esta cultura viene de los grandes clásicos: “Errare humanum est”. Todos cometemos fallos, en algún momento, nadie puede ser tan sumamente metódico que nunca cometa ningún error. El estrés, la falta de sueño, la salud emocional, la salud física, son todos factores que nos afectan en nuestro desempeño laboral. Y la cuestión más que “¿Qué voy a hacer SI fallo?” es “¿Qué voy a hacer CUANDO falle?”

### Cosas no tan bonitas de la cultura blameless

Pero no todo puede ser color de rosa. O por lo menos no en mi opinión.

Es un cambio doloroso y costoso. Y mucho. Y los principales culpables somos los propios individuos. ¿Por qué?

Porque nuestro cerebro está entrenado para buscar la culpa. Ya sea en otras personas o en otro elementos que no podemos controlar o predecir.

Según Brené Brown, PhD en trabajo social, el buscar la culpa es una forma de deshacernos del dolor y la falta de comfort emocional. 

Esto es extremadamente difícil de evitar, requiere que especialmente los responsables estén dotados de una alta sensibilidad emocional, sean especialmente asertivos y carentes de prejuicios. Vamos, prácticamente estamos hablando de unicornios. 

A mí personalmente, sigue costándome muchas veces deshacerme de todos los “bias” que acompañan a mi psique, pero es un trabajo continuo y arduo, para que la organización y los equipos puedan convertirse en máquinas de mejora continua (¿Alguien ha dicho Kaizen o Lean?). 

Tengo una opinión “criticona” con el propio nombre de “Blameless culture“ ya que basándome en los puntos que he comentado anteriormente, no sería realmente “Blameless”, ya que siempre hay “algo” que tendrá la “culpa”, si no que tendríamos que hablar de “Blame-aware culture” donde la culpa sea gestionada de una forma eficaz y aséptica. Pero como _buzzword_, “Blameless culture” tiene gancho. Así que seguiré usándolo.

Sobre los “bias” que típicamente acompañan a la mente humana, hablaré en otro momento.

### Blameless postmortems

Y entramos en La Niña Bonita de esta cultura, el sagrado grial de las organizaciones que se llaman “Blameless”, popularizada por los libros sobre Site Reliability Engineering de Google, implementada por todas las grandes organizaciones de ingeniería de IT (Facebook, Netflix, Etsy...) y usada erróneamente por muchas empresas.

**¿Qué es un Blameless postmortem?**

Básicamente sería vuestro Root Cause Analysis de toda la vida. Pero habiéndole inyectado esteroides. Incluyendo timelines detallados del incidente, capturas de pantalla, logs de chats, logs de aplicación, todo convenientemente hilvanado por un “Incident leader” que generalmente es o el ingeniero de guardia o la persona más senior de los que se vean implicados en un primer momento del incidente.

Como una de las características principales, este postmortem no ha de escribirse del final hacia atrás, si no desde el primer signo de incidente hasta el final, revisitando todas las decisiones, incluyendo los motivos por lo que se ha realizado una acción y su resultado. Esto permitirá hacer un seguimiento de las ineficiencias y errores de los procedimientos y de la organización y atajarlos más adelante mediante los denominados “action items”.

Se ha de escribir de la forma más aséptica posible, quitando la “culpa” de los individuos, por ejemplo en vez de “Víctor Fondevilla” estaríamos hablando del “ingeniero de guardia” o “equipo de Infraestructuras” o “equipo de desarrollo de la aplicación X”. Este es el primer paso para que la información fluya libremente y de manera detallada (Recordemos la “psychological safety”!). Una vez tenemos nuestro timeline detallado, encontraremos nuestro “falsa causa raíz”, que es bastante probable que sea “error humano”. A partir de ahí, escarbaremos en los motivos de este error humano, preguntándonos por qué ha pasado eso, y es bastante posible que terminemos en una decisión de negocio o error en la forma de hacer las cosas de la organización. Ese será el motivo real del fallo. Eso es lo que hay que atacar y arreglar más que colgar en público al ingeniero que cometió el fallo.

Y por último, tiene que haber una lista de “action items” o deberes para evitar que estas cosas vuelvan a pasar. Estos “action items” deben de tener un encargado, no en el sentido de implementarlo, si no en el sentido de perseguir que se implementen. Y estas cosas deberían tener el máximo de prioridad, ya que si no lo arreglas... ¿Es posible que vuelva a pasar?

Todo esto, permitirá que incidente a incidente, la organización mejore, paso a paso, mientras los ingenieros cada vez tendrán menos miedo a expresar sus fallos en público, ya que saben que serán protegidos por la organización.


### ¿Pero esto no implicaría que estás protegiendo la incompetencia?

Pues no. Por el simple hecho de que a pesar que se esté trabajando dentro de una organización blameless, los ingenieros siguen siendo responsables de los actos de clara incompetencia repetida o rendimiento insuficiente. Realmente, trabajar de esta forma implica que has hecho un buen trabajo de selección en cuanto a los ingenieros que forman parte de tu organización, ya no en sus conocimientos actuales si no en su “potencialidad” de aprender y ajustarse a nuevos paradigmas.

Si después de leer todo esto ves a tu organización reflejada, enhorabuena, estás en uno de los pocos sitios que realmente pueden considerarse “blameless”. Y yo por suerte estoy en uno de ellos, liderando la implementación de esta forma de trabajar.