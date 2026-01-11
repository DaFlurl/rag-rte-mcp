// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.digiTask

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.QuestBean;
    import mx.controls.Button;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import com.evony.GameConfig;
    import com.evony.common.module.quest.QuestListResponse;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.QuestTypeBean;
    import com.evony.common.module.quest.QuestTypeResponse;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class digiTask extends Canvas implements IBindingClient 
    {

        public static var instance:digiTask = new (digiTask)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var curQuest:QuestBean;
        private var _1271618531YesSubmitBtn:Button;
        private var _1660440092digiImg:Image;
        private var _1290918176evtImg:Image;
        private var _909756138strPicUrl:String = "";
        private var curQuestId:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":570,
                    "height":390,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"evtImg",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/icon/evony_qrcode2.png"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"digiImg",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":40,
                                "y":70
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"YesSubmitBtn",
                                    "events":{"click":"__YesSubmitBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Get Rewards",
                                            "styleName":"b95",
                                            "width":120,
                                            "height":25
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___digiTask_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function digiTask()
        {
            mx_internal::_document = this;
            this.width = 570;
            this.height = 390;
            this.styleName = "MyWindow";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            digiTask._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function show():void
        {
        }


        public function set evtImg(_arg_1:Image):void
        {
            var _local_2:Object = this._1290918176evtImg;
            if (_local_2 !== _arg_1)
            {
                this._1290918176evtImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "evtImg", _local_2, _arg_1));
            };
        }

        public function onQuestList(_arg_1:QuestListResponse):void
        {
            var _local_2:String;
            var _local_3:int;
            if (_arg_1.questsArray.length == 0)
            {
                return;
            };
            curQuest = (_arg_1.questsArray[0] as QuestBean);
            if (curQuest.isFinish)
            {
                return;
            };
            if (curQuest.name.indexOf("Welcome to a new way to play Evony.") == 0)
            {
                curQuestId = curQuest.questId;
                Context.getInstance().iDigiQuestId = curQuest.questId;
                if (strPicUrl.length > 0)
                {
                    return;
                };
                _local_2 = curQuest.targetsArray[0].name.toString();
                _local_3 = _local_2.indexOf("http://");
                strPicUrl = _local_2.substr(_local_3);
                strPicUrl = ((strPicUrl + "&sip=") + GameConfig.instance.serverIp);
                if (!Context.getInstance().facebookUser)
                {
                    strPicUrl = ((strPicUrl + "&pic=") + Context.getInstance().getPlayerBean().playerInfo.faceUrl);
                };
            };
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            award();
        }

        public function set YesSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1271618531YesSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1271618531YesSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "YesSubmitBtn", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:digiTask;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _digiTask_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_digiTaskWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get digiImg():Image
        {
            return (this._1660440092digiImg);
        }

        private function award():void
        {
            ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, Context.getInstance().iDigiQuestId);
        }

        public function onAwardResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                close();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get evtImg():Image
        {
            return (this._1290918176evtImg);
        }

        public function onQuestType(_arg_1:QuestTypeResponse):void
        {
            var _local_4:int;
            if (_arg_1.typesArray.length == 0)
            {
                return;
            };
            var _local_2:ArrayCollection = _arg_1.typesArray;
            trace("Task name:", QuestTypeBean(_local_2[0]).name);
            var _local_3:String = QuestTypeBean(_local_2[0]).name;
            if (_local_3.indexOf("Play Evony on Mobile") != -1)
            {
                _local_4 = QuestTypeBean(_local_2[0]).typeId;
                ActionFactory.getInstance().getQuestCommands().getQuestList(Context.getInstance().getCurCastle().id, _local_4);
            }
            else
            {
                if (Context.getInstance().iDigiTypeId > 0)
                {
                    ActionFactory.getInstance().getQuestCommands().getQuestList(Context.getInstance().getCurCastle().id, Context.getInstance().iDigiTypeId);
                }
                else
                {
                    close();
                };
            };
        }

        private function _digiTask_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = strPicUrl;
        }

        [Bindable(event="propertyChange")]
        private function get strPicUrl():String
        {
            return (this._909756138strPicUrl);
        }

        private function set strPicUrl(_arg_1:String):void
        {
            var _local_2:Object = this._909756138strPicUrl;
            if (_local_2 !== _arg_1)
            {
                this._909756138strPicUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strPicUrl", _local_2, _arg_1));
            };
        }

        public function set digiImg(_arg_1:Image):void
        {
            var _local_2:Object = this._1660440092digiImg;
            if (_local_2 !== _arg_1)
            {
                this._1660440092digiImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "digiImg", _local_2, _arg_1));
            };
        }

        private function _digiTask_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (strPicUrl);
            }, function (_arg_1:Object):void
            {
                digiImg.source = _arg_1;
            }, "digiImg.source");
            result[0] = binding;
            return (result);
        }

        public function ___digiTask_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }


    }
}//package view

