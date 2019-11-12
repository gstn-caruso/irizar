'From Cuis 5.0 [latest update: #3956] on 12 November 2019 at 12:45:27 am'!
'Description '!
!provides: 'Irizar' 1 0!
!requires: 'WebClient' 1 18 nil!
SystemOrganization addCategory: #'Irizar-Tests'!
SystemOrganization addCategory: #'Irizar-Core'!
SystemOrganization addCategory: #'Irizar-Core-Errors'!


!classDefinition: #RouteNotFound category: #'Irizar-Core-Errors'!
Error subclass: #RouteNotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Irizar-Core-Errors'!
!classDefinition: 'RouteNotFound class' category: #'Irizar-Core-Errors'!
RouteNotFound class
	instanceVariableNames: ''!

!classDefinition: #RouterTest category: #'Irizar-Tests'!
TestCase subclass: #RouterTest
	instanceVariableNames: 'port server'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Irizar-Tests'!
!classDefinition: 'RouterTest class' category: #'Irizar-Tests'!
RouterTest class
	instanceVariableNames: ''!

!classDefinition: #IrizarWebServer category: #'Irizar-Core'!
WebServer subclass: #IrizarWebServer
	instanceVariableNames: 'router'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Irizar-Core'!
!classDefinition: 'IrizarWebServer class' category: #'Irizar-Core'!
IrizarWebServer class
	instanceVariableNames: ''!

!classDefinition: #TestWebRequest category: #'Irizar-Tests'!
Object subclass: #TestWebRequest
	instanceVariableNames: 'url method'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Irizar-Tests'!
!classDefinition: 'TestWebRequest class' category: #'Irizar-Tests'!
TestWebRequest class
	instanceVariableNames: ''!

!classDefinition: #Router category: #'Irizar-Core'!
Object subclass: #Router
	instanceVariableNames: 'routes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Irizar-Core'!
!classDefinition: 'Router class' category: #'Irizar-Core'!
Router class
	instanceVariableNames: ''!

!classDefinition: #RoutingRule category: #'Irizar-Core'!
Object subclass: #RoutingRule
	instanceVariableNames: 'path handler httpVerb'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Irizar-Core'!
!classDefinition: 'RoutingRule class' category: #'Irizar-Core'!
RoutingRule class
	instanceVariableNames: ''!


!RouteNotFound class methodsFor: 'as yet unclassified' stamp: 'GC 11/11/2019 02:33:15'!
for: aRequest

	^ self new messageText: ('Route not found for {1} {2}' format: { aRequest method . aRequest rawUrl })! !

!RouterTest methodsFor: 'tests' stamp: 'GC 11/11/2019 02:08:07'!
testWhenThereAreNoRoutingRuleForARequestItFailsWith404
	| requestToUnexistantRoute router |
	
	router _ Router new.
	requestToUnexistantRoute _ TestWebRequest to: 'unexistant url'.
	
	self should: [ router route: requestToUnexistantRoute ] raise: RouteNotFound! !

!RouterTest methodsFor: 'tests' stamp: 'GC 11/11/2019 02:23:05'!
testWhenThereAreNoRoutingRuleForARequestWithCertainHttpVerbItFailsWith404
	| getRequest router |
	
	router _ Router new.
	getRequest _ TestWebRequest to: '/home_page'.
		
	router handle: '/home_page' verb: #POST with: [ :aRequest | ].

	
	self should: [ router route: getRequest ] raise: RouteNotFound! !

!RouterTest methodsFor: 'tests' stamp: 'GC 11/11/2019 02:08:39'!
testWhenThereIsARoutingRuleForARequestPathItSucceeds
	| sentRequest router handledRequest |
	
	router _ Router new.
	sentRequest _ TestWebRequest to: '/home_page'.
		
	router handle: '/home_page' with: [ :aRequest | handledRequest _ aRequest ].
	router route: sentRequest.
	
	self assert: sentRequest equals: handledRequest 
	! !

!IrizarWebServer methodsFor: 'accessing' stamp: 'GC 11/9/2019 21:13:43'!
router

	^ router! !

!IrizarWebServer methodsFor: 'handling' stamp: 'GC 11/9/2019 21:15:48'!
request: request

	self router route: request ! !

!IrizarWebServer methodsFor: 'initialize' stamp: 'GC 11/9/2019 21:12:03'!
initialize

	super initialize.
	router _ Router new! !

!TestWebRequest methodsFor: 'accessing' stamp: 'GC 11/11/2019 02:33:36'!
method

	^ method! !

!TestWebRequest methodsFor: 'accessing' stamp: 'GC 11/11/2019 02:33:36'!
method: anHttpVerb

	method _ anHttpVerb ! !

!TestWebRequest methodsFor: 'accessing' stamp: 'GC 11/9/2019 21:31:51'!
rawUrl

	^ url! !

!TestWebRequest methodsFor: 'accessing' stamp: 'GC 11/9/2019 21:31:09'!
url: aUrl

	url _ aUrl! !

!TestWebRequest class methodsFor: 'instance creation' stamp: 'GC 11/11/2019 02:11:19'!
to: aUrl

	^ self to: aUrl httpVerb: #GET! !

!TestWebRequest class methodsFor: 'instance creation' stamp: 'GC 11/11/2019 02:33:24'!
to: aUrl httpVerb: anHttpVerb

	^ self new url: aUrl; method: anHttpVerb! !

!Router methodsFor: 'accessing' stamp: 'GC 11/9/2019 21:29:58'!
routes

	^ routes! !

!Router methodsFor: 'initialize' stamp: 'GC 11/9/2019 21:30:07'!
initialize

	routes _ OrderedCollection new! !

!Router methodsFor: 'routing' stamp: 'GC 11/11/2019 02:24:44'!
handle: path verb: httpVerb with: anAction 
	|routingRule|
	
	routingRule _ RoutingRule to: path verb: httpVerb with: anAction.
	
	routes add: routingRule ! !

!Router methodsFor: 'routing' stamp: 'GC 11/11/2019 01:49:35'!
handle: aPath with: anAction
	|routingRule|
	
	routingRule _ RoutingRule to: aPath with: anAction.
	
	routes add: routingRule ! !

!Router methodsFor: 'routing' stamp: 'GC 11/11/2019 02:29:47'!
route: aRequest 

	^ self routes 
		detect: [ :route | route canHandle: aRequest ]
		ifFound: [ :routingRule | routingRule route: aRequest ]
		ifNone: [ RouteNotFound for: aRequest :: signal ]
! !

!RoutingRule methodsFor: 'accessing' stamp: 'GC 11/9/2019 22:38:35'!
route: aRequest

	handler value: aRequest ! !

!RoutingRule methodsFor: 'accessing' stamp: 'GC 11/11/2019 02:26:37'!
to: aPath verb: anHttpVerb with: anAction 
	path _ aPath.
	httpVerb _ anHttpVerb.
	handler _ anAction.! !

!RoutingRule methodsFor: 'accessing' stamp: 'GC 11/9/2019 22:06:28'!
to: aPath with: anAction

	path _ aPath.
	handler _ anAction 
	! !

!RoutingRule methodsFor: 'testing' stamp: 'GC 11/11/2019 02:33:15'!
canHandle: aWebRequest

	^ (aWebRequest rawUrl = path) and: [ aWebRequest method = httpVerb ]! !

!RoutingRule class methodsFor: 'instance creation' stamp: 'GC 11/11/2019 02:25:20'!
to: aPath verb: httpVerb with: anAction 
	^ self new to: aPath verb: httpVerb with: anAction! !

!RoutingRule class methodsFor: 'instance creation' stamp: 'GC 11/11/2019 02:32:22'!
to: aPath with: anAction 
	^ self to: aPath verb: #GET with: anAction ! !
