// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.technology.TechItemUI

package view.module.technology
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.AvailableResearchListBean;
    import mx.controls.Label;
    import mx.controls.Image;
    import view.ui.ConditionTooltip;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import com.evony.factory.UIFactory;
    import com.evony.Lang;
    import mx.managers.PopUpManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import flash.events.TimerEvent;
    import com.evony.client.action.ActionFactory;
    import view.ui.DescribeTooltip;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.TechEumDefine;
    import com.evony.eum.TechEum;
    import com.evony.factory.ImageManager;
    import com.evony.util.UIUtil;
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

    public class TechItemUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1525956411_techBean:AvailableResearchListBean;
        private var _1438160526techLevel:Label;
        private var _676507419typeName:Label;
        public var _TechItemUI_Image1:Image;
        private var _410464834imgSource:Object;
        private var _1312137351researchBtnVisable:Boolean = true;
        private var tips:ConditionTooltip;
        private var _id:int;
        public var _TechItemUI_Button1:Button;
        public var _TechItemUI_Button2:Button;
        public var _TechItemUI_Button3:Button;
        private var _1177331774itemName:String;
        private var _2116187592itemMes:String;
        private var _techTypeId:int;
        public var _TechItemUI_Canvas2:Canvas;
        public var _TechItemUI_Canvas3:Canvas;
        private var _1633303396techLevel2:Label;
        private var _1955688961isCanResearch:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":201,
                    "height":99,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_TechItemUI_Image1",
                        "events":{
                            "complete":"___TechItemUI_Image1_complete",
                            "mouseMove":"___TechItemUI_Image1_mouseMove",
                            "mouseOver":"___TechItemUI_Image1_mouseOver",
                            "mouseOut":"___TechItemUI_Image1_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.left = "10";
                            this.top = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":62,
                                "height":62,
                                "scaleContent":true
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"typeName",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"fontTitle",
                                "percentWidth":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"_TechItemUI_Canvas2",
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.bottom = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":65,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TechItemUI_Button1",
                                    "events":{
                                        "click":"___TechItemUI_Button1_click",
                                        "mouseOver":"___TechItemUI_Button1_mouseOver",
                                        "mouseOut":"___TechItemUI_Button1_mouseOut",
                                        "mouseMove":"___TechItemUI_Button1_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"techLevel",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "5";
                                        this.bottom = "30";
                                        this.textAlign = "right";
                                        this.left = "75";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp14s"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"_TechItemUI_Canvas3",
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.bottom = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":67,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TechItemUI_Button2",
                                    "events":{
                                        "click":"___TechItemUI_Button2_click",
                                        "mouseOver":"___TechItemUI_Button2_mouseOver",
                                        "mouseOut":"___TechItemUI_Button2_mouseOut",
                                        "mouseMove":"___TechItemUI_Button2_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 10;
                                        this.bottom = "27";
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b75",
                                            "width":115,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TechItemUI_Button3",
                                    "events":{"click":"___TechItemUI_Button3_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 10;
                                        this.bottom = "2";
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Research With Help",
                                            "styleName":"b75",
                                            "width":115,
                                            "height":22,
                                            "toolTip":"For each facebook friend that clicks on your feed,the research time will be reduced by either 1 minute or 1% whichever is greater. Up to 10 friends can speed up your research."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"techLevel2",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "5";
                                        this.bottom = "45";
                                        this.textAlign = "right";
                                        this.left = "75";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp14s"});
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var conditionTimer:Timer = new Timer(1000, 0);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TechItemUI()
        {
            mx_internal::_document = this;
            this.width = 201;
            this.height = 99;
            this.styleName = "textBackgroundShopTiles";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___TechItemUI_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TechItemUI._watcherSetupUtil = _arg_1;
        }


        public function destroy():void
        {
            this.conditionTimer.stop();
        }

        public function ___TechItemUI_Button1_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get typeName():Label
        {
            return (this._676507419typeName);
        }

        [Bindable(event="propertyChange")]
        public function get isCanResearch():Boolean
        {
            return (this._1955688961isCanResearch);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            if (this._techBean != null)
            {
                tips = UIFactory.getInstance().getConditionTooltip();
                tips.setTechType(Lang.msg("研究"), this._techBean.typeId, (this._techBean.level + 1));
                tips.setBean(this._techBean.conditionBean);
                tips.moveToMouse(_arg_1);
                if (tips.parent == null)
                {
                    PopUpManager.addPopUp(tips, this);
                }
                else
                {
                    PopUpManager.bringToFront(tips);
                };
            };
        }

        public function ___TechItemUI_Button2_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut(_arg_1);
        }

        override public function initialize():void
        {
            var target:TechItemUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TechItemUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_technology_TechItemUIWatcherSetupUtil");
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

        private function set _techBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1525956411_techBean;
            if (_local_2 !== _arg_1)
            {
                this._1525956411_techBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_techBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get techLevel():Label
        {
            return (this._1438160526techLevel);
        }

        public function set isCanResearch(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1955688961isCanResearch;
            if (_local_2 !== _arg_1)
            {
                this._1955688961isCanResearch = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanResearch", _local_2, _arg_1));
            };
        }

        private function _TechItemUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSource;
            _local_1 = itemName;
            _local_1 = (!(Context.getInstance().isBuildHelp));
            _local_1 = Lang.msg("研究");
            _local_1 = this.isCanResearch;
            _local_1 = this.researchBtnVisable;
            _local_1 = ((("Lv." + _techBean.level) + "/Ct.") + _techBean.avalevel);
            _local_1 = Context.getInstance().isBuildHelp;
            _local_1 = Lang.msg("研究");
            _local_1 = this.isCanResearch;
            _local_1 = this.researchBtnVisable;
            _local_1 = this.isCanResearch;
            _local_1 = ((this.researchBtnVisable) && (Context.getInstance().isBuildHelp));
            _local_1 = ((("Lv." + _techBean.level) + "/Ct.") + _techBean.avalevel);
        }

        private function set imgSource(_arg_1:Object):void
        {
            var _local_2:Object = this._410464834imgSource;
            if (_local_2 !== _arg_1)
            {
                this._410464834imgSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSource", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.conditionTimer.addEventListener(TimerEvent.TIMER, onConditionTime);
        }

        public function ___TechItemUI_Button2_click(_arg_1:MouseEvent):void
        {
            onStudy();
        }

        private function set itemMes(_arg_1:String):void
        {
            var _local_2:Object = this._2116187592itemMes;
            if (_local_2 !== _arg_1)
            {
                this._2116187592itemMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemMes", _local_2, _arg_1));
            };
        }

        private function set itemName(_arg_1:String):void
        {
            var _local_2:Object = this._1177331774itemName;
            if (_local_2 !== _arg_1)
            {
                this._1177331774itemName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemName", _local_2, _arg_1));
            };
        }

        private function onStudy():void
        {
            this.isCanResearch = false;
            this.destroy();
            ActionFactory.getInstance().getTechCommand().research(Context.getInstance().getCurCastle().id, this._techBean.typeId);
        }

        public function get techTypeId():int
        {
            return (this._techTypeId);
        }

        private function onPicMouseOut():void
        {
            DescribeTooltip.hide();
        }

        public function ___TechItemUI_Button2_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function ___TechItemUI_Button2_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function ___TechItemUI_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function onPicMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get imgSource():Object
        {
            return (this._410464834imgSource);
        }

        public function set techLevel2(_arg_1:Label):void
        {
            var _local_2:Object = this._1633303396techLevel2;
            if (_local_2 !== _arg_1)
            {
                this._1633303396techLevel2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techLevel2", _local_2, _arg_1));
            };
        }

        public function set techLevel(_arg_1:Label):void
        {
            var _local_2:Object = this._1438160526techLevel;
            if (_local_2 !== _arg_1)
            {
                this._1438160526techLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techLevel", _local_2, _arg_1));
            };
        }

        public function set techBean(_arg_1:AvailableResearchListBean):void
        {
            this.isCanResearch = false;
            this._techBean = _arg_1;
            this.onConditionTime(null);
            this.conditionTimer.start();
        }

        [Bindable(event="propertyChange")]
        private function get itemName():String
        {
            return (this._1177331774itemName);
        }

        [Bindable(event="propertyChange")]
        private function get itemMes():String
        {
            return (this._2116187592itemMes);
        }

        private function onPicMouseOver(_arg_1:MouseEvent):void
        {
            var _local_2:TechEum = TechEumDefine.getTechEumByType(_techBean.typeId);
            DescribeTooltip.show(_local_2.name, _local_2.wikiDesc, _arg_1);
        }

        public function ___TechItemUI_Image1_mouseOver(_arg_1:MouseEvent):void
        {
            onPicMouseOver(_arg_1);
        }

        public function set techTypeId(_arg_1:int):void
        {
            this.imgSource = ImageManager.getTechLogo(_arg_1);
            this._techTypeId = _arg_1;
            itemName = TechEumDefine.getTechEumByType(_techTypeId).name;
            itemMes = TechEumDefine.getTechEumByType(_techTypeId).desc;
        }

        public function set typeName(_arg_1:Label):void
        {
            var _local_2:Object = this._676507419typeName;
            if (_local_2 !== _arg_1)
            {
                this._676507419typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get researchBtnVisable():Boolean
        {
            return (this._1312137351researchBtnVisable);
        }

        [Bindable(event="propertyChange")]
        private function get _techBean():AvailableResearchListBean
        {
            return (this._1525956411_techBean);
        }

        public function ___TechItemUI_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onPicMouseMove(_arg_1);
        }

        private function onResearchWithHelp():void
        {
            onStudy();
            Context.getInstance().isResearchHelp = true;
            if (Context.getInstance().isBuildHelp)
            {
                Context.getInstance().isSpeedType = 1;
                Context.getInstance().buidwithhelpName = this.itemName;
                Context.getInstance().buidwithhelpLevel = String((this._techBean.level + 1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get techLevel2():Label
        {
            return (this._1633303396techLevel2);
        }

        public function ___TechItemUI_Button1_click(_arg_1:MouseEvent):void
        {
            onStudy();
        }

        public function ___TechItemUI_Button3_click(_arg_1:MouseEvent):void
        {
            onResearchWithHelp();
        }

        private function onMouseOut(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.destroy();
            };
            tips = null;
        }

        private function onConditionTime(_arg_1:TimerEvent):void
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            if (((!(this._techBean == null)) && (this._techBean.permition)))
            {
                _local_2 = UIUtil.isConditionMatch(this._techBean.conditionBean);
                _local_3 = UIUtil.isResourceConditionMatch(this._techBean.conditionBean);
                if (_local_3)
                {
                    this.conditionTimer.stop();
                };
                if (((_local_2) && (_local_3)))
                {
                    this.isCanResearch = true;
                };
            };
            UIUtil.isUIComponentVisible(this, this.conditionTimer);
        }

        public function ___TechItemUI_Image1_mouseOut(_arg_1:MouseEvent):void
        {
            onPicMouseOut();
        }

        public function set researchBtnVisable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1312137351researchBtnVisable;
            if (_local_2 !== _arg_1)
            {
                this._1312137351researchBtnVisable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "researchBtnVisable", _local_2, _arg_1));
            };
        }

        public function ___TechItemUI_Button1_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut(_arg_1);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.moveToMouse(_arg_1);
            };
        }

        public function ___TechItemUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _TechItemUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSource);
            }, function (_arg_1:Object):void
            {
                _TechItemUI_Image1.source = _arg_1;
            }, "_TechItemUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                typeName.text = _arg_1;
            }, "typeName.text");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(Context.getInstance().isBuildHelp));
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Canvas2.visible = _arg_1;
            }, "_TechItemUI_Canvas2.visible");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("研究");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TechItemUI_Button1.label = _arg_1;
            }, "_TechItemUI_Button1.label");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanResearch);
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Button1.enabled = _arg_1;
            }, "_TechItemUI_Button1.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.researchBtnVisable);
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Button1.visible = _arg_1;
            }, "_TechItemUI_Button1.visible");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((("Lv." + _techBean.level) + "/Ct.") + _techBean.avalevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                techLevel.text = _arg_1;
            }, "techLevel.text");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().isBuildHelp);
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Canvas3.visible = _arg_1;
            }, "_TechItemUI_Canvas3.visible");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("研究");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TechItemUI_Button2.label = _arg_1;
            }, "_TechItemUI_Button2.label");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanResearch);
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Button2.enabled = _arg_1;
            }, "_TechItemUI_Button2.enabled");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.researchBtnVisable);
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Button2.visible = _arg_1;
            }, "_TechItemUI_Button2.visible");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isCanResearch);
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Button3.enabled = _arg_1;
            }, "_TechItemUI_Button3.enabled");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.researchBtnVisable) && (Context.getInstance().isBuildHelp));
            }, function (_arg_1:Boolean):void
            {
                _TechItemUI_Button3.visible = _arg_1;
            }, "_TechItemUI_Button3.visible");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((("Lv." + _techBean.level) + "/Ct.") + _techBean.avalevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                techLevel2.text = _arg_1;
            }, "techLevel2.text");
            result[13] = binding;
            return (result);
        }

        public function ___TechItemUI_Button1_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }


    }
}//package view.module.technology

