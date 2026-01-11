// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.data.ChatContentData

package com.evony.data
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.collections.ArrayCollection;
    import com.evony.Context;
    import com.evony.Lang;
    import mx.utils.StringUtil;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.CommonConstants;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ChatContentData implements IEventDispatcher 
    {

        public static var instance:ChatContentData = new (ChatContentData)();

        private var _bindingEventDispatcher:EventDispatcher;

        private var _704570936worldChatList:ArrayCollection = new ArrayCollection();
        private var _1556596741unionChatList:ArrayCollection = new ArrayCollection();
        private var _953459385privateChatList:ArrayCollection = new ArrayCollection();
        private var _1150750267starterChatList:ArrayCollection = new ArrayCollection();
        private var _1882208733tallRecordArr:ArrayCollection = new ArrayCollection();
        private var _2095657228playerName:String = Context.getInstance().getPlayerBean().playerInfo.userName;

        public function ChatContentData()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        [Bindable(event="propertyChange")]
        public function get privateChatList():ArrayCollection
        {
            return (this._953459385privateChatList);
        }

        public function sendMes(_arg_1:String, _arg_2:String, _arg_3:int):void
        {
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:int;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:String;
            var _local_14:int;
            _arg_1 = _arg_1.replace("<", "&lt;");
            var _local_4:Array = analysisString(_arg_1);
            if (_local_4.length > 0)
            {
                _arg_1 = _local_4[0];
                _local_5 = _local_4[0];
                if (playerName == _local_5)
                {
                    _worldChatList = (("<b><font color = '#848484' >" + Lang.msg("请不要自己和自己说话")) + "</b></font>");
                    _privateChatList = (("<b><font color = '#848484' >" + Lang.msg("请不要自己和自己说话")) + "</b></font>");
                }
                else
                {
                    _local_6 = StringUtil.trim(_local_4[1]);
                    if (_local_6.length < 1)
                    {
                        _worldChatList = (("<b><font color='#848484' >" + Lang.msg("不允许发送空白或空格信息")) + "</font></b>");
                        _privateChatList = (("<b><font color='#848484' >" + Lang.msg("不允许发送空白或空格信息")) + "</font></b>");
                        return;
                    };
                    ActionFactory.getInstance().getCommonCommands().privateChat(_local_5, _local_4[1]);
                    _local_7 = (((((' [<u><b><a href="' + "event:") + _local_5) + '">') + _local_5) + "</a></b></u>]");
                    _local_8 = ((Lang.msg("你对{0}说", _local_7) + ": ") + _local_4[1]);
                    _worldChatList = (("<font color='#ff00ea' >" + _local_8) + "</font>");
                    _privateChatList = (("<font color='#ff00ea' >" + _local_8) + "</font>");
                    _unionChatList = (("<font color='#ff00ea' >" + _local_8) + "</font>");
                    _starterChatList = (("<font color='#ff00ea' >" + _local_8) + "</font>");
                    filterRepeat(((("/" + _local_5) + " ") + _local_4[1]));
                };
            }
            else
            {
                if (_arg_1 == "showversion")
                {
                    _worldChatList = (("<b><font color = '#848484' >" + EvonyClientVersion.VERSION) + "</b></font>");
                    return;
                };
                _local_9 = "";
                _local_10 = Context.getInstance().iXcState;
                _local_11 = new Date().getHours();
                _local_12 = new Date().getMinutes();
                _local_13 = (((("<font>&lt;" + ((_local_11 >= 10) ? _local_11.toString() : ("0" + _local_11.toString()))) + ":") + ((_local_12 >= 10) ? _local_12.toString() : ("0" + _local_12.toString()))) + "&gt;</font>");
                _local_9 = (getChatPic(_local_10) + _local_13);
                _local_9 = ((((_local_9 + "<b>[") + playerName) + "]: </b>") + _arg_1);
                _local_14 = Context.getInstance().getPlayerBean().playerInfo.bdenyotherplayer;
                if (((_arg_2 == "world") && (!(_local_14 == 1))))
                {
                    _local_9 = ("[World]" + _local_9);
                }
                else
                {
                    if (((_arg_2 == "private") && (!(_local_14 == 1))))
                    {
                        _local_9 = ("[Whisper]" + _local_9);
                    }
                    else
                    {
                        if (((_arg_2 == "alliance") && (!(_local_14 == 1))))
                        {
                            _local_9 = ("[Alliance]" + _local_9);
                        };
                    };
                };
                if (_local_14 == 1)
                {
                    _local_9 = ("[Staff]" + _local_9);
                };
                if (((_arg_2 == "world") || (_arg_2 == "private")))
                {
                    if (!Context.getInstance().bVictor)
                    {
                        if (_local_14 == 1)
                        {
                            _worldChatList = (("<font color='#006600' >" + _local_9) + "</font>");
                            _starterChatList = (("<font color='#006600' >" + _local_9) + "</font>");
                        }
                        else
                        {
                            _worldChatList = (("<font color='#000000' >" + _local_9) + "</font>");
                            _starterChatList = (("<font color='#000000' >" + _local_9) + "</font>");
                        };
                    };
                    ActionFactory.getInstance().getCommonCommands().worldChat(_arg_1, _arg_3);
                    filterRepeat(_arg_1);
                }
                else
                {
                    if (_arg_2 == "alliance")
                    {
                        if (!Context.getInstance().bVictor)
                        {
                            if (_local_14 == 1)
                            {
                                _worldChatList = (("<font color='#006600' >" + _local_9) + "</font>");
                                _unionChatList = (("<font color='#006600' >" + _local_9) + "</font>");
                                _starterChatList = (("<font color='#006600' >" + _local_9) + "</font>");
                            }
                            else
                            {
                                _worldChatList = (("<font color='#0042e9' >" + _local_9) + "</font>");
                                _unionChatList = (("<font color='#0042e9' >" + _local_9) + "</font>");
                                _starterChatList = (("<font color='#0042e9' >" + _local_9) + "</font>");
                            };
                        };
                        ActionFactory.getInstance().getCommonCommands().allianceChat(_arg_1, _arg_3);
                        filterRepeat(_arg_1);
                    }
                    else
                    {
                        if (_arg_2 == "starter")
                        {
                            if (!Context.getInstance().bVictor)
                            {
                                if (_local_14 == 1)
                                {
                                    _starterChatList = (("<font color='#006600' >" + _local_9) + "</font>");
                                }
                                else
                                {
                                    _starterChatList = (("<font color='#000000' >" + _local_9) + "</font>");
                                };
                            };
                            ActionFactory.getInstance().getCommonCommands().channelChat(CommonConstants.CHAT_CHANNEL_BEGINNER, _arg_1, _arg_3);
                        };
                    };
                };
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set tallRecordArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1882208733tallRecordArr;
            if (_local_2 !== _arg_1)
            {
                this._1882208733tallRecordArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tallRecordArr", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set _tallRecordArr(_arg_1:String):void
        {
            tallRecordArr.addItem(_arg_1);
            checkArr(tallRecordArr);
        }

        public function set _starterChatList(_arg_1:String):void
        {
            starterChatList.addItem(_arg_1);
            checkArr(starterChatList);
        }

        private function analysisString(_arg_1:String):Array
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_2:Array = new Array();
            if (_arg_1.substr(0, 1) == "/")
            {
                if (_arg_1.substr(1, 1) == "'")
                {
                    _local_3 = _arg_1.indexOf("'", 3);
                    if (_local_3 > -1)
                    {
                        _local_4 = _arg_1.indexOf(" ", _local_3);
                        if (_local_4 > _local_3)
                        {
                            _local_2.push(_arg_1.slice(2, _local_3));
                            _local_2.push(_arg_1.slice((_local_4 + 1), _arg_1.length));
                        }
                        else
                        {
                            _local_2 = [];
                        };
                    }
                    else
                    {
                        _local_2 = [];
                    };
                }
                else
                {
                    _local_5 = _arg_1.indexOf(" ", 1);
                    if (_local_5 > -1)
                    {
                        _local_2.push(_arg_1.slice(1, _local_5));
                        _local_2.push(_arg_1.slice((_local_5 + 1), _arg_1.length));
                    }
                    else
                    {
                        _local_2 = [];
                    };
                };
            }
            else
            {
                _local_2 = [];
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get worldChatList():ArrayCollection
        {
            return (this._704570936worldChatList);
        }

        public function set worldChatList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._704570936worldChatList;
            if (_local_2 !== _arg_1)
            {
                this._704570936worldChatList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "worldChatList", _local_2, _arg_1));
            };
        }

        public function set unionChatList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1556596741unionChatList;
            if (_local_2 !== _arg_1)
            {
                this._1556596741unionChatList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unionChatList", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function clearTallList():void
        {
            this.worldChatList = new ArrayCollection();
            this.unionChatList = new ArrayCollection();
            this.privateChatList = new ArrayCollection();
        }

        public function set _worldChatList(_arg_1:String):void
        {
            worldChatList.addItem(_arg_1);
            checkArr(worldChatList);
        }

        public function set _unionChatList(_arg_1:String):void
        {
            unionChatList.addItem(_arg_1);
            checkArr(unionChatList);
        }

        public function getChatPic(_arg_1:int):String
        {
            var _local_2:* = "";
            if (_arg_1 == CommonConstants.SPEAK_BPAP_15)
            {
                _local_2 = "<img src='images/icon/player/jt_15.png' width='15' height='15' vspace='0'>";
            }
            else
            {
                if (_arg_1 == CommonConstants.SPEAK_BPAP)
                {
                    _local_2 = "<img src='images/icon/player/jt_infinite.png' width='15' height='15' vspace='0'>";
                }
                else
                {
                    if (_arg_1 == CommonConstants.SPEAK_SPAP_15)
                    {
                        _local_2 = "<img src='images/icon/player/by_15.png' width='15' height='15' vspace='0'>";
                    }
                    else
                    {
                        if (_arg_1 == CommonConstants.SPEAK_SPAP)
                        {
                            _local_2 = "<img src='images/icon/player/by_infinite.png' width='15' height='15' vspace='0'>";
                        }
                        else
                        {
                            if (_arg_1 == CommonConstants.SPEAK_GPAP_15)
                            {
                                _local_2 = "<img src='images/icon/player/hj_15.png' width='15' height='15' vspace='0'>";
                            }
                            else
                            {
                                if (_arg_1 == CommonConstants.SPEAK_GPAP)
                                {
                                    _local_2 = "<img src='images/icon/player/hj_infinite.png' width='15' height='15' vspace='0'>";
                                };
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get unionChatList():ArrayCollection
        {
            return (this._1556596741unionChatList);
        }

        public function set playerName(_arg_1:String):void
        {
            var _local_2:Object = this._2095657228playerName;
            if (_local_2 !== _arg_1)
            {
                this._2095657228playerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _local_2, _arg_1));
            };
        }

        public function removeIndexItem(_arg_1:ArrayCollection, _arg_2:int):void
        {
            if (_arg_1.length > 0)
            {
                if (((_arg_2 < 0) || (_arg_2 >= length)))
                {
                    _arg_1.removeItemAt((_arg_1.length - 1));
                }
                else
                {
                    _arg_1.removeItemAt(_arg_2);
                };
            };
        }

        public function set starterChatList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1150750267starterChatList;
            if (_local_2 !== _arg_1)
            {
                this._1150750267starterChatList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "starterChatList", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get tallRecordArr():ArrayCollection
        {
            return (this._1882208733tallRecordArr);
        }

        [Bindable(event="propertyChange")]
        public function get playerName():String
        {
            return (this._2095657228playerName);
        }

        [Bindable(event="propertyChange")]
        public function get starterChatList():ArrayCollection
        {
            return (this._1150750267starterChatList);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set privateChatList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._953459385privateChatList;
            if (_local_2 !== _arg_1)
            {
                this._953459385privateChatList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "privateChatList", _local_2, _arg_1));
            };
        }

        private function filterRepeat(_arg_1:String):void
        {
            var _local_2:int;
            if (tallRecordArr.length >= 1)
            {
                _local_2 = (tallRecordArr.length - 1);
                if (_arg_1 != tallRecordArr[_local_2])
                {
                    _tallRecordArr = _arg_1;
                };
            }
            else
            {
                _tallRecordArr = _arg_1;
            };
        }

        public function set _privateChatList(_arg_1:String):void
        {
            privateChatList.addItem(_arg_1);
            checkArr(privateChatList);
        }

        private function checkArr(_arg_1:ArrayCollection):ArrayCollection
        {
            if (_arg_1.length < 100)
            {
                return (_arg_1);
            };
            _arg_1.removeItemAt(0);
            return (_arg_1);
        }


    }
}//package com.evony.data

