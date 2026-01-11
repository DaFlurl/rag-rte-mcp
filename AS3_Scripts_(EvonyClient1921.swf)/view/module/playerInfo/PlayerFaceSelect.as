// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.PlayerFaceSelect

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.RadioButtonGroup;
    import mx.controls.Button;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.controls.RadioButton;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.ItemClickEvent;
    import com.evony.Context;
    import com.evony.eum.LogoEumDefine;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import flash.display.Bitmap;
    import flash.events.Event;
    import view.ui.AlertWin;
    import com.evony.common.module.common.ChangeUserFaceResponse;
    import com.evony.client.action.ActionFactory;
    import mx.events.FlexEvent;
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

    public class PlayerFaceSelect extends Canvas implements IBindingClient 
    {

        public static var instance:PlayerFaceSelect = new (PlayerFaceSelect)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _642046766SexFlag:Boolean = true;
        private var _1354303084cp_sex:RadioButtonGroup;
        public var _PlayerFaceSelect_Button3:Button;
        public var _PlayerFaceSelect_Image1:Image;
        private var sex:int = 0;
        public var _PlayerFaceSelect_Label1:Label;
        public var _PlayerFaceSelect_RadioButton2:RadioButton;
        private var _571486424faceSource:String;
        public var _PlayerFaceSelect_RadioButton1:RadioButton;
        private var faceIndex:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":314,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_PlayerFaceSelect_Label1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":175,
                                "y":6,
                                "width":0xFF,
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.horizontalCenter = "0";
                            this.horizontalAlign = "left";
                            this.top = "150";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_PlayerFaceSelect_RadioButton1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"groupName":"cp_sex"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_PlayerFaceSelect_RadioButton2",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"groupName":"cp_sex"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.horizontalCenter = "0";
                            this.horizontalAlign = "center";
                            this.top = "210";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___PlayerFaceSelect_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previous"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___PlayerFaceSelect_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"next"});
                                                }
                                            })]});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_PlayerFaceSelect_Button3",
                        "events":{"click":"___PlayerFaceSelect_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "50";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"Blue75"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_PlayerFaceSelect_Image1",
                        "events":{"complete":"___PlayerFaceSelect_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":100,
                                "x":170
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"The portrait or gender can only be changed once.",
                                "styleName":"ParamgraphText1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___PlayerFaceSelect_Button4_click"},
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
        private var faceArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PlayerFaceSelect()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 314;
            _PlayerFaceSelect_RadioButtonGroup1_i();
            this.addEventListener("creationComplete", ___PlayerFaceSelect_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PlayerFaceSelect._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        public function ___PlayerFaceSelect_Button2_click(_arg_1:MouseEvent):void
        {
            changeFace(1);
        }

        public function ___PlayerFaceSelect_Button4_click(_arg_1:MouseEvent):void
        {
            MinePopupManager.instance.removePopup();
        }

        override public function initialize():void
        {
            var target:PlayerFaceSelect;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PlayerFaceSelect_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_PlayerFaceSelectWatcherSetupUtil");
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
        public function get cp_sex():RadioButtonGroup
        {
            return (this._1354303084cp_sex);
        }

        private function handleSex(_arg_1:ItemClickEvent):void
        {
            this.sex = _arg_1.index;
            this.resetFaceArray();
        }

        private function init():void
        {
            this.sex = Context.getInstance().getPlayerBean().playerInfo.sex;
            if (Context.getInstance().getPlayerBean().playerInfo.sex == 0)
            {
                SexFlag = true;
                this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            }
            else
            {
                SexFlag = false;
                this.faceArray = LogoEumDefine.getFemalePlayerLogoArray();
            };
            var _local_1:int;
            while (_local_1 < this.faceArray.length)
            {
                if (this.faceArray[_local_1].toString() == Context.getInstance().getPlayerBean().playerInfo.faceUrl)
                {
                    this.faceIndex = _local_1;
                    break;
                };
                _local_1++;
            };
            this.faceSource = this.faceArray[faceIndex];
        }

        private function set SexFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._642046766SexFlag;
            if (_local_2 !== _arg_1)
            {
                this._642046766SexFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SexFlag", _local_2, _arg_1));
            };
        }

        private function _PlayerFaceSelect_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("玩家头像更改");
            _local_1 = Lang.msg("男");
            _local_1 = ((SexFlag) ? true : false);
            _local_1 = Lang.msg("女");
            _local_1 = ((SexFlag) ? false : true);
            _local_1 = Lang.msg("更改");
            _local_1 = this.faceSource;
        }

        public function set cp_sex(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._1354303084cp_sex;
            if (_local_2 !== _arg_1)
            {
                this._1354303084cp_sex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_sex", _local_2, _arg_1));
            };
        }

        public function __cp_sex_itemClick(_arg_1:ItemClickEvent):void
        {
            handleSex(_arg_1);
        }

        private function changeFace(_arg_1:int):void
        {
            this.faceIndex = (this.faceIndex + _arg_1);
            if (this.faceIndex < 0)
            {
                this.faceIndex = (this.faceArray.length - 1);
            }
            else
            {
                if (this.faceIndex >= this.faceArray.length)
                {
                    this.faceIndex = 0;
                };
            };
            this.faceSource = this.faceArray[this.faceIndex];
        }

        private function set faceSource(_arg_1:String):void
        {
            var _local_2:Object = this._571486424faceSource;
            if (_local_2 !== _arg_1)
            {
                this._571486424faceSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceSource", _local_2, _arg_1));
            };
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function ___PlayerFaceSelect_Button1_click(_arg_1:MouseEvent):void
        {
            changeFace(-1);
        }

        private function _PlayerFaceSelect_RadioButtonGroup1_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            cp_sex = _local_1;
            _local_1.addEventListener("itemClick", __cp_sex_itemClick);
            _local_1.initialized(this, "cp_sex");
            return (_local_1);
        }

        public function ___PlayerFaceSelect_Button3_click(_arg_1:MouseEvent):void
        {
            onSubmit();
        }

        private function _PlayerFaceSelect_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家头像更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerFaceSelect_Label1.text = _arg_1;
            }, "_PlayerFaceSelect_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("男");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerFaceSelect_RadioButton1.label = _arg_1;
            }, "_PlayerFaceSelect_RadioButton1.label");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((SexFlag) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _PlayerFaceSelect_RadioButton1.selected = _arg_1;
            }, "_PlayerFaceSelect_RadioButton1.selected");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("女");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerFaceSelect_RadioButton2.label = _arg_1;
            }, "_PlayerFaceSelect_RadioButton2.label");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((SexFlag) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _PlayerFaceSelect_RadioButton2.selected = _arg_1;
            }, "_PlayerFaceSelect_RadioButton2.selected");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerFaceSelect_Button3.label = _arg_1;
            }, "_PlayerFaceSelect_Button3.label");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.faceSource);
            }, function (_arg_1:Object):void
            {
                _PlayerFaceSelect_Image1.source = _arg_1;
            }, "_PlayerFaceSelect_Image1.source");
            result[6] = binding;
            return (result);
        }

        private function onChangeResponse(_arg_1:ChangeUserFaceResponse):void
        {
            if (_arg_1.ok)
            {
                AlertWin.show(Lang.msg("成功更改头像"));
                Context.getInstance().getPlayerBean().playerInfo.faceUrl = this.faceSource;
                Context.getInstance().getPlayerBean().changedFace = true;
                MinePopupManager.instance.removePopup();
            };
        }

        [Bindable(event="propertyChange")]
        private function get SexFlag():Boolean
        {
            return (this._642046766SexFlag);
        }

        private function onSubmit():void
        {
            ActionFactory.getInstance().getCommonCommands().changeUserFace(this.faceSource, this.sex, onChangeResponse);
        }

        public function ___PlayerFaceSelect_Image1_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get faceSource():String
        {
            return (this._571486424faceSource);
        }

        public function ___PlayerFaceSelect_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function resetFaceArray():void
        {
            this.faceIndex = 0;
            if (this.sex == 0)
            {
                this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            }
            else
            {
                this.faceArray = LogoEumDefine.getFemalePlayerLogoArray();
            };
            this.faceSource = this.faceArray[this.faceIndex];
        }


    }
}//package view.module.playerInfo

