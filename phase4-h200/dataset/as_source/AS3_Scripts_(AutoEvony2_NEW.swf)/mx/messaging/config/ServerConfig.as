// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.config.ServerConfig

package mx.messaging.config
{
    import mx.resources.IResourceManager;
    import mx.messaging.ChannelSet;
    import mx.messaging.errors.InvalidDestinationError;
    import mx.collections.ArrayCollection;
    import mx.messaging.Channel;
    import flash.utils.getQualifiedClassName;
    import mx.messaging.MessageAgent;
    import mx.messaging.errors.InvalidChannelError;
    import flash.utils.getDefinitionByName;
    import mx.utils.ObjectUtil;
    import mx.resources.ResourceManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ServerConfig 
    {

        public static const CLASS_ATTR:String = "type";
        public static const URI_ATTR:String = "uri";
        private static var _resourceManager:IResourceManager;
        public static var serverConfigData:XML;
        private static var _channelSets:Object = {};
        private static var _clusteredChannels:Object = {};
        private static var _unclusteredChannels:Object = {};
        private static var _configFetchedChannels:Object;
        public static var channelSetFactory:Class = ChannelSet;


        public static function getProperties(destinationId:String):XMLList
        {
            var destination:XMLList;
            var message:String;
            destination = xml..destination.(@id == destinationId);
            if (destination.length() > 0)
            {
                return (destination.properties);
            };
            message = resourceManager.getString("messaging", "unknownDestination", [destinationId]);
            throw (new InvalidDestinationError(message));
        }

        mx_internal static function getChannelIdList(_arg_1:String):Array
        {
            var _local_2:XML = getDestinationConfig(_arg_1);
            return ((_local_2) ? getChannelIds(_local_2) : getDefaultChannelIds());
        }

        private static function convertToXML(_arg_1:ConfigMap, _arg_2:XML):void
        {
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:XML;
            var _local_8:XML;
            for (_local_3 in _arg_1)
            {
                _local_4 = _arg_1[_local_3];
                if ((_local_4 is String))
                {
                    if (_local_3 == "")
                    {
                        _arg_2.appendChild(_local_4);
                    }
                    else
                    {
                        _arg_2.@[_local_3] = _local_4;
                    };
                }
                else
                {
                    if (((_local_4 is ArrayCollection) || (_local_4 is Array)))
                    {
                        if ((_local_4 is ArrayCollection))
                        {
                            _local_5 = ArrayCollection(_local_4).toArray();
                        }
                        else
                        {
                            _local_5 = (_local_4 as Array);
                        };
                        _local_6 = 0;
                        while (_local_6 < _local_5.length)
                        {
                            _local_7 = new (XML)((((("<" + _local_3) + "></") + _local_3) + ">"));
                            _arg_2.appendChild(_local_7);
                            convertToXML((_local_5[_local_6] as ConfigMap), _local_7);
                            _local_6++;
                        };
                    }
                    else
                    {
                        _local_8 = new (XML)((((("<" + _local_3) + "></") + _local_3) + ">"));
                        _arg_2.appendChild(_local_8);
                        convertToXML((_local_4 as ConfigMap), _local_8);
                    };
                };
            };
        }

        public static function getChannel(_arg_1:String, _arg_2:Boolean=false):Channel
        {
            var _local_3:Channel;
            if (!_arg_2)
            {
                if ((_arg_1 in _unclusteredChannels))
                {
                    return (_unclusteredChannels[_arg_1]);
                };
                _local_3 = createChannel(_arg_1);
                _unclusteredChannels[_arg_1] = _local_3;
                return (_local_3);
            };
            if ((_arg_1 in _clusteredChannels))
            {
                return (_clusteredChannels[_arg_1]);
            };
            _local_3 = createChannel(_arg_1);
            _clusteredChannels[_arg_1] = _local_3;
            return (_local_3);
        }

        mx_internal static function needsConfig(_arg_1:Channel):Boolean
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:int;
            if (((_configFetchedChannels == null) || (_configFetchedChannels[_arg_1.endpoint] == null)))
            {
                _local_2 = _arg_1.channelSets;
                _local_3 = _local_2.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    if (getQualifiedClassName(_local_2[_local_4]).indexOf("Advanced") != -1)
                    {
                        return (true);
                    };
                    _local_5 = ChannelSet(_local_2[_local_4]).messageAgents;
                    _local_6 = _local_5.length;
                    _local_7 = 0;
                    while (_local_7 < _local_6)
                    {
                        if (MessageAgent(_local_5[_local_7]).needsConfig)
                        {
                            return (true);
                        };
                        _local_7++;
                    };
                    _local_4++;
                };
            };
            return (false);
        }

        public static function getChannelSet(_arg_1:String):ChannelSet
        {
            var _local_2:XML = getDestinationConfig(_arg_1);
            return (internalGetChannelSet(_local_2, _arg_1));
        }

        public static function get xml():XML
        {
            if (serverConfigData == null)
            {
                serverConfigData = <services/>
                ;
            };
            return (serverConfigData);
        }

        mx_internal static function updateServerConfigData(serverConfig:ConfigMap, endpoint:String=null):void
        {
            var newServices:XML;
            var newService:XML;
            var newChannels:XMLList;
            var oldServices:XMLList;
            var oldDestinations:XMLList;
            var newDestination:XML;
            var oldService:XML;
            var oldChannels:XML;
            if (serverConfig != null)
            {
                if (endpoint != null)
                {
                    if (_configFetchedChannels == null)
                    {
                        _configFetchedChannels = {};
                    };
                    _configFetchedChannels[endpoint] = true;
                };
                newServices = <services></services>
                ;
                convertToXML(serverConfig, newServices);
                xml["default-channels"] = newServices["default-channels"];
                for each (newService in newServices..service)
                {
                    oldServices = xml.service.(@id == newService.@id);
                    if (oldServices.length() != 0)
                    {
                        oldService = oldServices[0];
                        for each (newDestination in newService..destination)
                        {
                            oldDestinations = oldService.destination.(@id == newDestination.@id);
                            if (oldDestinations.length() != 0)
                            {
                                delete oldDestinations[0];
                            };
                            oldService.appendChild(newDestination.copy());
                        };
                    }
                    else
                    {
                        for each (newDestination in newService..destination)
                        {
                            oldDestinations = xml..destination.(@id == newDestination.@id);
                            if (oldDestinations.length() != 0)
                            {
                                oldDestinations[0] = newDestination[0].copy();
                                delete newService..destination.(@id == newDestination.@id)[0];
                            };
                        };
                        if (newService.children().length() > 0)
                        {
                            xml.appendChild(newService);
                        };
                    };
                };
                newChannels = newServices.channels;
                if (newChannels.length() > 0)
                {
                    oldChannels = xml.channels[0];
                    if (((oldChannels == null) || (oldChannels.length() == 0)))
                    {
                        xml.appendChild(newChannels);
                    };
                };
            };
        }

        private static function internalGetChannelSet(_arg_1:XML, _arg_2:String):ChannelSet
        {
            var _local_3:Array;
            var _local_4:Boolean;
            var _local_6:String;
            var _local_7:ChannelSet;
            var _local_8:int;
            if (_arg_1 == null)
            {
                _local_3 = getDefaultChannelIds();
                if (_local_3.length == 0)
                {
                    _local_6 = resourceManager.getString("messaging", "noChannelForDestination", [_arg_2]);
                    throw (new InvalidDestinationError(_local_6));
                };
                _local_4 = false;
            }
            else
            {
                _local_3 = getChannelIds(_arg_1);
                _local_4 = ((_arg_1.properties.network.cluster.length() > 0) ? true : false);
            };
            var _local_5:String = ((_local_3.join(",") + ":") + _local_4);
            if ((_local_5 in _channelSets))
            {
                return (_channelSets[_local_5]);
            };
            _local_7 = new channelSetFactory(_local_3, _local_4);
            _local_8 = serverConfigData["flex-client"]["heartbeat-interval-millis"];
            if (_local_8 > 0)
            {
                _local_7.heartbeatInterval = _local_8;
            };
            if (_local_4)
            {
                _local_7.initialDestinationId = _arg_2;
            };
            _channelSets[_local_5] = _local_7;
            return (_local_7);
        }

        private static function getDefaultChannelIds():Array
        {
            var _local_1:Array = [];
            var _local_2:XMLList = xml["default-channels"].channel;
            var _local_3:int = _local_2.length();
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_1.push(_local_2[_local_4].@ref.toString());
                _local_4++;
            };
            return (_local_1);
        }

        private static function createChannel(channelId:String):Channel
        {
            var message:String;
            var channels:XMLList;
            var channelConfig:XML;
            var className:String;
            var endpoint:XMLList;
            var uri:String;
            var channel:Channel;
            var channelClass:Class;
            channels = xml.channels.channel.(@id == channelId);
            if (channels.length() == 0)
            {
                message = resourceManager.getString("messaging", "unknownChannelWithId", [channelId]);
                throw (new InvalidChannelError(message));
            };
            channelConfig = channels[0];
            className = channelConfig.attribute(CLASS_ATTR).toString();
            endpoint = channelConfig.endpoint;
            uri = ((endpoint.length() > 0) ? endpoint[0].attribute(URI_ATTR).toString() : null);
            channel = null;
            try
            {
                channelClass = (getDefinitionByName(className) as Class);
                channel = new (channelClass)(channelId, uri);
                channel.applySettings(channelConfig);
                if (((!(LoaderConfig.parameters == null)) && (!(LoaderConfig.parameters.WSRP_ENCODED_CHANNEL == null))))
                {
                    channel.url = LoaderConfig.parameters.WSRP_ENCODED_CHANNEL;
                };
            }
            catch(e:ReferenceError)
            {
                message = resourceManager.getString("messaging", "unknownChannelClass", [className]);
                throw (new InvalidChannelError(message));
            };
            return (channel);
        }

        public static function set xml(_arg_1:XML):void
        {
            serverConfigData = _arg_1;
            _channelSets = {};
            _clusteredChannels = {};
            _unclusteredChannels = {};
        }

        private static function getChannelIds(_arg_1:XML):Array
        {
            var _local_2:Array = [];
            var _local_3:XMLList = _arg_1.channels.channel;
            var _local_4:int = _local_3.length();
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_2.push(_local_3[_local_5].@ref.toString());
                _local_5++;
            };
            return (_local_2);
        }

        private static function getDestinationConfig(destinationId:String):XML
        {
            var destinations:XMLList;
            var destinationCount:int;
            destinations = xml..destination.(@id == destinationId);
            destinationCount = destinations.length();
            if (destinationCount == 0)
            {
                return (null);
            };
            return (destinations[0]);
        }

        mx_internal static function fetchedConfig(_arg_1:String):Boolean
        {
            return ((!(_configFetchedChannels == null)) && (!(_configFetchedChannels[_arg_1] == null)));
        }

        mx_internal static function channelSetMatchesDestinationConfig(channelSet:ChannelSet, destination:String):Boolean
        {
            var csUris:Array;
            var csChannels:Array;
            var i:uint;
            var ids:Array;
            var dsUris:Array;
            var dsChannels:XMLList;
            var channelConfig:XML;
            var endpoint:XML;
            var dsUri:String;
            var j:uint;
            if (channelSet != null)
            {
                if (ObjectUtil.compare(channelSet.channelIds, getChannelIdList(destination)) == 0)
                {
                    return (true);
                };
                csUris = [];
                csChannels = channelSet.channels;
                i = 0;
                while (i < csChannels.length)
                {
                    csUris.push(csChannels[i].uri);
                    i++;
                };
                ids = getChannelIdList(destination);
                dsUris = [];
                j = 0;
                while (j < ids.length)
                {
                    dsChannels = xml.channels.channel.(@id == ids[j]);
                    channelConfig = dsChannels[0];
                    endpoint = channelConfig.endpoint;
                    dsUri = ((endpoint.length() > 0) ? endpoint[0].attribute(URI_ATTR).toString() : null);
                    if (dsUri != null)
                    {
                        dsUris.push(dsUri);
                    };
                    j++;
                };
                return (ObjectUtil.compare(csUris, dsUris) == 0);
            };
            return (false);
        }

        public static function checkChannelConsistency(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Array = getChannelIdList(_arg_1);
            var _local_4:Array = getChannelIdList(_arg_2);
            if (ObjectUtil.compare(_local_3, _local_4) != 0)
            {
                throw (new ArgumentError("Specified destinations are not channel consistent"));
            };
        }

        private static function get resourceManager():IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            };
            return (_resourceManager);
        }


    }
}//package mx.messaging.config

