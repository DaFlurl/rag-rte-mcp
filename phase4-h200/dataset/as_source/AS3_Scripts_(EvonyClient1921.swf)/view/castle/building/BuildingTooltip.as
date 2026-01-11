// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.building.BuildingTooltip

package view.castle.building
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.BuildingBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.utils.ChangeWatcher;
    import com.evony.Lang;
    import mx.binding.utils.BindingUtils;
    import com.evony.eum.BuildingEumDefine;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.constants.BuildingConstants;
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

    public class BuildingTooltip extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _BuildingTooltip_Label1:Label;
        private var _1106127544levelL:Label;
        private var _982612129buildingName:String;
        private var _397924048buildingLevel:String;
        private var _3019696bean:BuildingBean;
        public var _BuildingTooltip_Label3:Label;
        private var _762902470buildingStatus:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":40,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.paddingTop = 5;
                            this.paddingBottom = 5;
                            this.paddingLeft = 8;
                            this.paddingRight = 8;
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":38,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuildingTooltip_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"levelL",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ParamgraphText1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuildingTooltip_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ParamgraphText1"});
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var watchers:Array = [];
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BuildingTooltip()
        {
            mx_internal::_document = this;
            this.height = 40;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuildingTooltip._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get buildingName():String
        {
            return (this._982612129buildingName);
        }

        public function set buildingLevel(_arg_1:String):void
        {
            var _local_2:Object = this._397924048buildingLevel;
            if (_local_2 !== _arg_1)
            {
                this._397924048buildingLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingLevel", _local_2, _arg_1));
            };
        }

        public function set buildingName(_arg_1:String):void
        {
            var _local_2:Object = this._982612129buildingName;
            if (_local_2 !== _arg_1)
            {
                this._982612129buildingName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingStatus():String
        {
            return (this._762902470buildingStatus);
        }

        public function set buildingBean(_arg_1:BuildingBean):void
        {
            var _local_2:ChangeWatcher;
            this.bean = _arg_1;
            this.buildingLevel = (Lang.msg("等级（简）") + this.bean.level);
            for each (_local_2 in this.watchers)
            {
                _local_2.unwatch();
            };
            watchers[0] = BindingUtils.bindProperty(this, "onBuildingStatusChange", _arg_1, "status");
            this.buildingName = BuildingEumDefine.getName(_arg_1.typeId);
        }

        [Bindable(event="propertyChange")]
        public function get levelL():Label
        {
            return (this._1106127544levelL);
        }

        override public function initialize():void
        {
            var target:BuildingTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BuildingTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_building_BuildingTooltipWatcherSetupUtil");
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
        public function get buildingLevel():String
        {
            return (this._397924048buildingLevel);
        }

        private function _BuildingTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingTooltip_Label1.text = _arg_1;
            }, "_BuildingTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                levelL.text = _arg_1;
            }, "levelL.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingStatus;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingTooltip_Label3.text = _arg_1;
            }, "_BuildingTooltip_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.buildingStatus == "") ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BuildingTooltip_Label3.visible = _arg_1;
            }, "_BuildingTooltip_Label3.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.buildingStatus == "") ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BuildingTooltip_Label3.includeInLayout = _arg_1;
            }, "_BuildingTooltip_Label3.includeInLayout");
            result[4] = binding;
            return (result);
        }

        public function set buildingStatus(_arg_1:String):void
        {
            var _local_2:Object = this._762902470buildingStatus;
            if (_local_2 !== _arg_1)
            {
                this._762902470buildingStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingStatus", _local_2, _arg_1));
            };
        }

        public function set onBuildingStatusChange(_arg_1:int):void
        {
            if (bean != null)
            {
                if (bean.status == BuildingConstants.STATUS_NORMAL)
                {
                    this.buildingStatus = "";
                }
                else
                {
                    if (bean.status == BuildingConstants.STATUS_UPGRADING)
                    {
                        this.buildingStatus = Lang.msg("升级中");
                    }
                    else
                    {
                        if (bean.status == BuildingConstants.STATUS_DESTRUCTING)
                        {
                            this.buildingStatus = Lang.msg("拆除中");
                        }
                        else
                        {
                            if (bean.status == BuildingConstants.STATUS_WAITING)
                            {
                                this.buildingStatus = Lang.msg("等待中");
                            };
                        };
                    };
                };
            }
            else
            {
                this.buildingStatus = "";
            };
        }

        public function noWall(_arg_1:String):void
        {
            this.buildingStatus = "";
            this.buildingName = _arg_1;
            this.buildingLevel = "";
        }

        private function _BuildingTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.buildingName;
            _local_1 = this.buildingLevel;
            _local_1 = this.buildingStatus;
            _local_1 = ((this.buildingStatus == "") ? false : true);
            _local_1 = ((this.buildingStatus == "") ? false : true);
        }

        public function set levelL(_arg_1:Label):void
        {
            var _local_2:Object = this._1106127544levelL;
            if (_local_2 !== _arg_1)
            {
                this._1106127544levelL = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levelL", _local_2, _arg_1));
            };
        }

        private function set bean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get bean():BuildingBean
        {
            return (this._3019696bean);
        }


    }
}//package view.castle.building

