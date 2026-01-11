// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.EffortFinishWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.QuestBean;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.EvonyImage;
    import mx.controls.SWFLoader;
    import mx.controls.Button;
    import flash.utils.ByteArray;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.data.FbData;
    import com.evony.Context;
    import flash.external.ExternalInterface;
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

    public class EffortFinishWin extends Canvas implements IBindingClient 
    {

        private static var instance:EffortFinishWin = new (EffortFinishWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _616135290showBuffPic:Boolean = false;
        private var _1335001103finishQuest:QuestBean;
        public var _EffortFinishWin_HBox1:HBox;
        private var _curPicPath:String = "images/dynamicImages/effortfinish/";
        private var _1349156931curLev:String = "0";
        private var _364633395awardPoint:String;
        private var _334905522toolTipStr:String;
        private var _98615765grats:String;
        private var _1753618744leftPicPath:String;
        private var _177689032smallPicPath:String;
        public var _EffortFinishWin_Image1:Image;
        public var _EffortFinishWin_Image3:Image;
        public var _EffortFinishWin_Label1:Label;
        public var _EffortFinishWin_Image2:Image;
        private var _currStr:String = "images/dynamicImages/effort/effort";
        public var _EffortFinishWin_Text1:Text;
        private var _99346des:String;
        private var _1916786312imgPath:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":757,
                    "height":610,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.top = "70";
                            this.left = "110";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@yellow_bg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.top = "65";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@icon_bg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_EffortFinishWin_Image1",
                        "stylesFactory":function ():void
                        {
                            this.left = "46";
                            this.top = "71";
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/effortfinish.swf",
                                "scaleX":0.85,
                                "scaleY":0.85
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_EffortFinishWin_Image2",
                        "stylesFactory":function ():void
                        {
                            this.top = "75";
                            this.left = "230";
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___EffortFinishWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "50";
                            this.left = "300";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"effortfacebookbtn"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "205";
                            this.left = "95";
                            this.right = "95";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":75,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_EffortFinishWin_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.top = "2";
                                        this.left = "2";
                                        this.right = "2";
                                        this.textAlign = "center";
                                        this.fontSize = 16;
                                        this.kerning = true;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":73,
                                            "width":530
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "stylesFactory":function ():void
                        {
                            this.fontSize = 20;
                            this.color = 16773941;
                            this.top = "300";
                            this.left = "190";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"winTitleBuildingLevel",
                                "text":"Achievement points: ",
                                "width":300
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_EffortFinishWin_Label1",
                        "stylesFactory":function ():void
                        {
                            this.fontSize = 20;
                            this.color = 16773941;
                            this.top = "300";
                            this.left = "520";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"winTitleBuildingLevel",
                                "width":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_EffortFinishWin_HBox1",
                        "stylesFactory":function ():void
                        {
                            this.top = "360";
                            this.left = "190";
                            this.right = "95";
                            this.horizontalGap = 145;
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 20;
                                        this.color = 16773941;
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"winTitleBuildingLevel",
                                            "text":"Buff obtained : "
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_EffortFinishWin_Image3"
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.color = 0xFFFFFF;
                            this.fontSize = 16;
                            this.bottom = "130";
                            this.left = "125";
                            this.kerning = true;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"contentHeader1",
                                "text":"Tips: Share your great deeds with friends to get even more rewards!"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___EffortFinishWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.right = "29";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":SWFLoader,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/effortfinish_light.swf",
                                            "x":-20,
                                            "y":-20
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var randPicArr:Array = ["amazing.png", "awesome.png", "brilliant.png", "excellent.png", "glorious.png", "incredible.png", "magnificent.png", "marvelous.png", "perfect.png", "splendid.png", "Superb.png", "wonderful.png"];
        private var BuffxmlClass:Class = EffortFinishWin_BuffxmlClass;
        private var xml_ba:ByteArray = (new BuffxmlClass() as ByteArray);
        private var BuffxmlObj:XML = XML(xml_ba);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EffortFinishWin()
        {
            mx_internal::_document = this;
            this.width = 757;
            this.height = 610;
            this.styleName = "effortfinishbg";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EffortFinishWin._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function show(_arg_1:QuestBean):void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            if (_arg_1 != null)
            {
                instance.finishQuest = _arg_1;
                instance.showGrats();
            };
        }


        [Bindable(event="propertyChange")]
        private function get showBuffPic():Boolean
        {
            return (this._616135290showBuffPic);
        }

        [Bindable(event="propertyChange")]
        private function get des():String
        {
            return (this._99346des);
        }

        override public function initialize():void
        {
            var target:EffortFinishWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EffortFinishWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_EffortFinishWinWatcherSetupUtil");
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
        private function get imgPath():String
        {
            return (this._1916786312imgPath);
        }

        private function set toolTipStr(_arg_1:String):void
        {
            var _local_2:Object = this._334905522toolTipStr;
            if (_local_2 !== _arg_1)
            {
                this._334905522toolTipStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toolTipStr", _local_2, _arg_1));
            };
        }

        private function set finishQuest(_arg_1:QuestBean):void
        {
            var _local_2:Object = this._1335001103finishQuest;
            if (_local_2 !== _arg_1)
            {
                this._1335001103finishQuest = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finishQuest", _local_2, _arg_1));
            };
        }

        public function ___EffortFinishWin_Button1_click(_arg_1:MouseEvent):void
        {
            facebookshare();
        }

        private function set grats(_arg_1:String):void
        {
            var _local_2:Object = this._98615765grats;
            if (_local_2 !== _arg_1)
            {
                this._98615765grats = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "grats", _local_2, _arg_1));
            };
        }

        private function set des(_arg_1:String):void
        {
            var _local_2:Object = this._99346des;
            if (_local_2 !== _arg_1)
            {
                this._99346des = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "des", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get finishQuest():QuestBean
        {
            return (this._1335001103finishQuest);
        }

        private function setBuffImg(_arg_1:String):String
        {
            var _local_2:* = "";
            var _local_3:int = BuffxmlObj.children().length();
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (BuffxmlObj.child(_local_4).@id == _arg_1)
                {
                    _local_2 = BuffxmlObj.child(_local_4).@img;
                    toolTipStr = ((BuffxmlObj.child(_local_4).@desc + String((int(BuffxmlObj.child(_local_4).@per) * int(curLev)))) + "%");
                    break;
                };
                _local_4++;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get awardPoint():String
        {
            return (this._364633395awardPoint);
        }

        [Bindable(event="propertyChange")]
        private function get curLev():String
        {
            return (this._1349156931curLev);
        }

        [Bindable(event="propertyChange")]
        private function get leftPicPath():String
        {
            return (this._1753618744leftPicPath);
        }

        private function parseDescription(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:int;
            var _local_5:int;
            var _local_2:* = "";
            if (_arg_1.search(":") != -1)
            {
                _local_4 = _arg_1.search(":");
                _local_5 = _arg_1.search("/");
                _local_2 = _arg_1.slice(0, _local_4);
                showBuffPic = true;
                _local_3 = _arg_1.slice((_local_4 + 1), _local_5);
                curLev = _arg_1.slice((_local_5 + 1));
                smallPicPath = ((setBuffImg(_local_3) + curLev) + ".png");
                if (smallPicPath == null)
                {
                    smallPicPath = "images/dynamicImages/accBuff/grievance2.png";
                };
            }
            else
            {
                showBuffPic = false;
            };
        }

        [Bindable(event="propertyChange")]
        private function get smallPicPath():String
        {
            return (this._177689032smallPicPath);
        }

        [Bindable(event="propertyChange")]
        private function get grats():String
        {
            return (this._98615765grats);
        }

        private function set imgPath(_arg_1:String):void
        {
            var _local_2:Object = this._1916786312imgPath;
            if (_local_2 !== _arg_1)
            {
                this._1916786312imgPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgPath", _local_2, _arg_1));
            };
        }

        private function showGrats():void
        {
            var _local_2:Object;
            var _local_1:int = int(Math.floor((Math.random() * 12)));
            this.grats = (this._curPicPath + this.randPicArr[_local_1]);
            if (this.grats == null)
            {
                this.grats = "images/dynamicImages/effortfinish/amazing.png";
            };
            if (this.finishQuest != null)
            {
                this.des = (("<FONT COLOR='#FBF805'>" + this.finishQuest.manual.toUpperCase()) + "</FONT>");
                parseDescription(this.finishQuest.description);
                _local_2 = FbData.getInstance().getValue(this.finishQuest.questId);
                imgPath = _local_2.img;
                if (imgPath == null)
                {
                    imgPath = "http://betadownload.evony.com/images/feed/2.png";
                };
                this.awardPoint = ("+" + this.finishQuest.award);
            };
        }

        private function _EffortFinishWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgPath;
            _local_1 = this.grats;
            _local_1 = (("Your people have completed " + this.des) + " under your rule! They become richer and happier! Our great kingdom becomes stronger!");
            _local_1 = this.awardPoint;
            _local_1 = this.showBuffPic;
            _local_1 = this.smallPicPath;
            _local_1 = this.toolTipStr;
        }

        private function set curLev(_arg_1:String):void
        {
            var _local_2:Object = this._1349156931curLev;
            if (_local_2 !== _arg_1)
            {
                this._1349156931curLev = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curLev", _local_2, _arg_1));
            };
        }

        private function set leftPicPath(_arg_1:String):void
        {
            var _local_2:Object = this._1753618744leftPicPath;
            if (_local_2 !== _arg_1)
            {
                this._1753618744leftPicPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leftPicPath", _local_2, _arg_1));
            };
        }

        private function set awardPoint(_arg_1:String):void
        {
            var _local_2:Object = this._364633395awardPoint;
            if (_local_2 !== _arg_1)
            {
                this._364633395awardPoint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "awardPoint", _local_2, _arg_1));
            };
        }

        private function facebookshare():void
        {
            var _local_1:Object;
            close();
            if (Context.getInstance().facebookUser)
            {
                _local_1 = FbData.getInstance().getValue(this.finishQuest.questId);
                if (_local_1 != null)
                {
                    FacebookNoticeWin.show(_local_1);
                };
            }
            else
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("facebook.checkFB", true, Context.getInstance().userName);
                };
            };
        }

        private function _EffortFinishWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgPath);
            }, function (_arg_1:Object):void
            {
                _EffortFinishWin_Image1.source = _arg_1;
            }, "_EffortFinishWin_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.grats);
            }, function (_arg_1:Object):void
            {
                _EffortFinishWin_Image2.source = _arg_1;
            }, "_EffortFinishWin_Image2.source");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("Your people have completed " + this.des) + " under your rule! They become richer and happier! Our great kingdom becomes stronger!");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EffortFinishWin_Text1.htmlText = _arg_1;
            }, "_EffortFinishWin_Text1.htmlText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.awardPoint;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EffortFinishWin_Label1.text = _arg_1;
            }, "_EffortFinishWin_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showBuffPic);
            }, function (_arg_1:Boolean):void
            {
                _EffortFinishWin_HBox1.visible = _arg_1;
            }, "_EffortFinishWin_HBox1.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.smallPicPath);
            }, function (_arg_1:Object):void
            {
                _EffortFinishWin_Image3.source = _arg_1;
            }, "_EffortFinishWin_Image3.source");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.toolTipStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EffortFinishWin_Image3.toolTip = _arg_1;
            }, "_EffortFinishWin_Image3.toolTip");
            result[6] = binding;
            return (result);
        }

        public function ___EffortFinishWin_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        private function get toolTipStr():String
        {
            return (this._334905522toolTipStr);
        }

        private function set smallPicPath(_arg_1:String):void
        {
            var _local_2:Object = this._177689032smallPicPath;
            if (_local_2 !== _arg_1)
            {
                this._177689032smallPicPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "smallPicPath", _local_2, _arg_1));
            };
        }

        private function set showBuffPic(_arg_1:Boolean):void
        {
            var _local_2:Object = this._616135290showBuffPic;
            if (_local_2 !== _arg_1)
            {
                this._616135290showBuffPic = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showBuffPic", _local_2, _arg_1));
            };
        }


    }
}//package view.ui

