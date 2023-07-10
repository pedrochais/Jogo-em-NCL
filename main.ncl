<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="nclClicks" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<head>

<regionBase>
    <region width="300px" height="50px"  left="35%"  top="0%" id="rgWin"/>
    <region width="500px" height="500px"  left="22.5%" top="10%" id="rgLua"/>
</regionBase>

<descriptorBase>
    <descriptor id="dsLua" region="rgLua" focusIndex="luaIdx"/>
    <descriptor id="dsWin" region="rgWin"/>
</descriptorBase>

<connectorBase>
	<causalConnector id="onBeginStart">
		<simpleCondition role="onBegin"/>
		<simpleAction role="start"/>
	</causalConnector>
</connectorBase>

</head>

<body>
    <port id="entryPoint" component="lua"/>

	<media type="application/x-ginga-settings" id="programSettings">
        <property name="service.currentKeyMaster" value="luaIdx"/>
	</media>

    <media id="lua" src="game.lua" descriptor="dsLua">
        <area id="fim"/>
    </media>

    <media id="win" src="ganhou.png" descriptor="dsWin"/>

    <link xconnector="onBeginStart">
        <bind role="onBegin" component="lua" interface="fim"/>
		<bind role="start" component="win"/>
	</link>
</body>

</ncl>
