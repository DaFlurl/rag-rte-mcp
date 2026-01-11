// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.TroopUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.utils.ObjectProxy;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.factory.ImageManager;
    import com.evony.eum.FortificationEumDefine;
    import com.evony.eum.TroopEumDefine;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class TroopUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TroopUi_Label2:Label;
        private var _1682502725troopObj:ObjectProxy;
        public var _TroopUi_Image1:Image;
        private var _858803723typeId:int;
        private var _1523380288_imgSrc:Object;
        public var _TroopUi_Label3:Label;
        public var _TroopUi_Label4:Label;
        public var _TroopUi_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":35,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_TroopUi_Image1",
                                    "events":{"creationComplete":"___TroopUi_Image1_creationComplete"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":25,
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TroopUi_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "-126";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":110});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TroopUi_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":90});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TroopUi_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":110});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TroopUi_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":90});
                                    }
                                })]
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

        public function TroopUi()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.height = 35;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopUi._watcherSetupUtil = _arg_1;
        }


        private function _TroopUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = getImgSrc(this.troopObj.typeId);
            _local_1 = getTypeName(this.typeId);
            _local_1 = this.troopObj.preCount;
            _local_1 = ((this.troopObj.preCount == null) ? false : true);
            _local_1 = ((this.troopObj.preCount == null) ? false : true);
            _local_1 = this.troopObj.remain;
            _local_1 = ((this.troopObj.remain == null) ? false : true);
            _local_1 = ((this.troopObj.remain == null) ? false : true);
            _local_1 = this.troopObj.injured;
            _local_1 = ((this.troopObj.injured == null) ? false : true);
            _local_1 = ((this.troopObj.injured == null) ? false : true);
        }

        [Bindable(event="propertyChange")]
        private function get typeId():int
        {
            return (this._858803723typeId);
        }

        [Bindable(event="propertyChange")]
        private function get _imgSrc():Object
        {
            return (this._1523380288_imgSrc);
        }

        public function ___TroopUi_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function set _imgSrc(_arg_1:Object):void
        {
            var _local_2:Object = this._1523380288_imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1523380288_imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_imgSrc", _local_2, _arg_1));
            };
        }

        private function set troopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1682502725troopObj;
            if (_local_2 !== _arg_1)
            {
                this._1682502725troopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopObj", _local_2, _arg_1));
            };
        }

        private function getImgSrc(_arg_1:int):Object
        {
            this.typeId = _arg_1;
            if (_arg_1 >= 14)
            {
                this._imgSrc = ImageManager.getFortSmallLogo(_arg_1);
            }
            else
            {
                this._imgSrc = ImageManager.getTroopSmallLogo(_arg_1);
            };
            return (this._imgSrc);
        }

        private function getTypeName(_arg_1:int):String
        {
            var _local_2:String;
            if (_arg_1 >= 14)
            {
                _local_2 = FortificationEumDefine.getFortificationEumByType(_arg_1).name;
            }
            else
            {
                _local_2 = TroopEumDefine.getTroopEumByType(_arg_1).name;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get troopObj():ObjectProxy
        {
            return (this._1682502725troopObj);
        }

        override public function initialize():void
        {
            var target:TroopUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_TroopUiWatcherSetupUtil");
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

        private function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        public function set troopInfoObj(_arg_1:Object):void
        {
            this.troopObj = ObjectProxy(_arg_1);
        }

        private function _TroopUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (getImgSrc(this.troopObj.typeId));
            }, function (_arg_1:Object):void
            {
                _TroopUi_Image1.source = _arg_1;
            }, "_TroopUi_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = getTypeName(this.typeId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopUi_Label1.text = _arg_1;
            }, "_TroopUi_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopObj.preCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopUi_Label2.text = _arg_1;
            }, "_TroopUi_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopObj.preCount == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopUi_Label2.visible = _arg_1;
            }, "_TroopUi_Label2.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopObj.preCount == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopUi_Label2.includeInLayout = _arg_1;
            }, "_TroopUi_Label2.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopObj.remain;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopUi_Label3.text = _arg_1;
            }, "_TroopUi_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopObj.remain == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopUi_Label3.visible = _arg_1;
            }, "_TroopUi_Label3.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopObj.remain == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopUi_Label3.includeInLayout = _arg_1;
            }, "_TroopUi_Label3.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopObj.injured;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopUi_Label4.text = _arg_1;
            }, "_TroopUi_Label4.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopObj.injured == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopUi_Label4.visible = _arg_1;
            }, "_TroopUi_Label4.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.troopObj.injured == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _TroopUi_Label4.includeInLayout = _arg_1;
            }, "_TroopUi_Label4.includeInLayout");
            result[10] = binding;
            return (result);
        }


    }
}//package view.module.info.reports.ReportUi

