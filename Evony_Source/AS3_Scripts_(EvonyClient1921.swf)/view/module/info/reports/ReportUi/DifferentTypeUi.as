// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.DifferentTypeUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.eum.BuildingEumDefine;
    import com.evony.eum.TechEumDefine;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.eum.FortificationEumDefine;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import com.evony.eum.TroopEumDefine;
    import com.evony.Lang;
    import com.evony.factory.ImageManager;
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

    public class DifferentTypeUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1523380365_imgStr:Object;
        private var _2939591_num:*;
        private var _1180281131isName:Boolean = true;
        private var _100469305isImg:Boolean = true;
        public var _DifferentTypeUi_Image1:Image;
        public var _DifferentTypeUi_Label1:Label;
        public var _DifferentTypeUi_Label2:Label;
        public var _DifferentTypeUi_Label3:Label;
        public var _DifferentTypeUi_HBox1:HBox;
        private var _585989564_typeName:String;
        public var _DifferentTypeUi_Label4:Label;
        public var _DifferentTypeUi_HBox2:HBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":25,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_DifferentTypeUi_HBox1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_DifferentTypeUi_Image1",
                                    "events":{"creationComplete":"___DifferentTypeUi_Image1_creationComplete"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":25,
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_DifferentTypeUi_Label1"
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_DifferentTypeUi_Label2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":25});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_DifferentTypeUi_HBox2",
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_DifferentTypeUi_Label3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":25,
                                            "width":150
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_DifferentTypeUi_Label4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":25});
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function DifferentTypeUi()
        {
            mx_internal::_document = this;
            this.height = 25;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            DifferentTypeUi._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get _imgStr():Object
        {
            return (this._1523380365_imgStr);
        }

        private function set _num(_arg_1:*):void
        {
            var _local_2:Object = this._2939591_num;
            if (_local_2 !== _arg_1)
            {
                this._2939591_num = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_num", _local_2, _arg_1));
            };
        }

        private function set _typeName(_arg_1:String):void
        {
            var _local_2:Object = this._585989564_typeName;
            if (_local_2 !== _arg_1)
            {
                this._585989564_typeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_typeName", _local_2, _arg_1));
            };
        }

        public function set buildType(_arg_1:int):void
        {
            this._typeName = BuildingEumDefine.getBuildingEumByType(_arg_1).name;
            this.isImg = false;
        }

        public function set num(_arg_1:*):void
        {
            this._num = _arg_1;
        }

        public function set teachType(_arg_1:int):void
        {
            this._typeName = TechEumDefine.getTechEumByType(_arg_1).name;
            this.isImg = false;
        }

        private function set _imgStr(_arg_1:Object):void
        {
            var _local_2:Object = this._1523380365_imgStr;
            if (_local_2 !== _arg_1)
            {
                this._1523380365_imgStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_imgStr", _local_2, _arg_1));
            };
        }

        private function set isName(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180281131isName;
            if (_local_2 !== _arg_1)
            {
                this._1180281131isName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isName", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:DifferentTypeUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DifferentTypeUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_DifferentTypeUiWatcherSetupUtil");
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

        private function _DifferentTypeUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (this.isImg);
            }, function (_arg_1:Boolean):void
            {
                _DifferentTypeUi_HBox1.visible = _arg_1;
            }, "_DifferentTypeUi_HBox1.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isImg);
            }, function (_arg_1:Boolean):void
            {
                _DifferentTypeUi_HBox1.includeInLayout = _arg_1;
            }, "_DifferentTypeUi_HBox1.includeInLayout");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this._imgStr);
            }, function (_arg_1:Object):void
            {
                _DifferentTypeUi_Image1.source = _arg_1;
            }, "_DifferentTypeUi_Image1.source");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._typeName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DifferentTypeUi_Label1.text = _arg_1;
            }, "_DifferentTypeUi_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._num;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DifferentTypeUi_Label2.text = _arg_1;
            }, "_DifferentTypeUi_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isName);
            }, function (_arg_1:Boolean):void
            {
                _DifferentTypeUi_HBox2.visible = _arg_1;
            }, "_DifferentTypeUi_HBox2.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isName);
            }, function (_arg_1:Boolean):void
            {
                _DifferentTypeUi_HBox2.includeInLayout = _arg_1;
            }, "_DifferentTypeUi_HBox2.includeInLayout");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._typeName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DifferentTypeUi_Label3.text = _arg_1;
            }, "_DifferentTypeUi_Label3.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._num;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DifferentTypeUi_Label4.text = _arg_1;
            }, "_DifferentTypeUi_Label4.text");
            result[8] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get isImg():Boolean
        {
            return (this._100469305isImg);
        }

        [Bindable(event="propertyChange")]
        private function get _typeName():String
        {
            return (this._585989564_typeName);
        }

        [Bindable(event="propertyChange")]
        private function get _num():*
        {
            return (this._2939591_num);
        }

        public function set fortType(_arg_1:int):void
        {
            this._typeName = FortificationEumDefine.getFortificationEumByType(_arg_1).name;
            this.isImg = false;
        }

        private function _DifferentTypeUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.isImg;
            _local_1 = this.isImg;
            _local_1 = this._imgStr;
            _local_1 = this._typeName;
            _local_1 = this._num;
            _local_1 = this.isName;
            _local_1 = this.isName;
            _local_1 = this._typeName;
            _local_1 = this._num;
        }

        public function ___DifferentTypeUi_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get isName():Boolean
        {
            return (this._1180281131isName);
        }

        public function set troopType(_arg_1:int):void
        {
            this._typeName = TroopEumDefine.getTroopEumByType(_arg_1).name;
            this.isImg = false;
        }

        public function set resourceType(_arg_1:String):void
        {
            if (_arg_1 == "wood")
            {
                this._typeName = Lang.msg("木材");
            };
            if (_arg_1 == "food")
            {
                this._typeName = Lang.msg("粮食");
            };
            if (_arg_1 == "stone")
            {
                this._typeName = Lang.msg("石料");
            };
            if (_arg_1 == "iron")
            {
                this._typeName = Lang.msg("铁矿");
            };
            if (_arg_1 == "gold")
            {
                this._typeName = Lang.msg("黄金");
            };
            this.isImg = false;
        }

        public function set resourceSrc(_arg_1:String):void
        {
            if (_arg_1 == "wood")
            {
                this._typeName = Lang.msg("木材");
            };
            if (_arg_1 == "food")
            {
                this._typeName = Lang.msg("粮食");
            };
            if (_arg_1 == "stone")
            {
                this._typeName = Lang.msg("石料");
            };
            if (_arg_1 == "iron")
            {
                this._typeName = Lang.msg("铁矿");
            };
            if (_arg_1 == "gold")
            {
                this._typeName = Lang.msg("黄金");
            };
            this._imgStr = ImageManager.getResourceLogo(_arg_1);
            this.isName = false;
        }

        private function set isImg(_arg_1:Boolean):void
        {
            var _local_2:Object = this._100469305isImg;
            if (_local_2 !== _arg_1)
            {
                this._100469305isImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isImg", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

