// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.SuzerainInfoTooltip

package view.castleList
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.ColonyBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
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

    public class SuzerainInfoTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:SuzerainInfoTooltip = new (SuzerainInfoTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1421682026cityName:Label;
        private var _94845685coord:Label;
        private var _1420526811citytype:Label;
        private var _1197684682colonyBean:ColonyBean;
        private var _680808764isColony:Boolean;
        private var _1197902024colonyInfo:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.left = "5";
                            this.top = "5";
                            this.bottom = "5";
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"citytype",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"cityName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"coord",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line2.png"});
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SuzerainInfoTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
            this.addEventListener("creationComplete", ___SuzerainInfoTooltip_BaseTooltip1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SuzerainInfoTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():SuzerainInfoTooltip
        {
            return (instance);
        }


        private function set colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._1197684682colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._1197684682colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBean", _local_2, _arg_1));
            };
        }

        public function set cityName(_arg_1:Label):void
        {
            var _local_2:Object = this._1421682026cityName;
            if (_local_2 !== _arg_1)
            {
                this._1421682026cityName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityName", _local_2, _arg_1));
            };
        }

        private function _SuzerainInfoTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.isColony) ? "colony" : "suzerain");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                citytype.text = _arg_1;
            }, "citytype.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.cityName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityName.text = _arg_1;
            }, "cityName.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + this.colonyBean.position.replace(".", ",")) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                coord.text = _arg_1;
            }, "coord.text");
            result[2] = binding;
            return (result);
        }

        private function set colonyInfo(_arg_1:String):void
        {
            var _local_2:Object = this._1197902024colonyInfo;
            if (_local_2 !== _arg_1)
            {
                this._1197902024colonyInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isColony():Boolean
        {
            return (this._680808764isColony);
        }

        [Bindable(event="propertyChange")]
        private function get colonyInfo():String
        {
            return (this._1197902024colonyInfo);
        }

        override public function initialize():void
        {
            var target:SuzerainInfoTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SuzerainInfoTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_SuzerainInfoTooltipWatcherSetupUtil");
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

        public function setCastleBean(_arg_1:ColonyBean, _arg_2:Boolean):void
        {
            this.colonyBean = _arg_1;
            this.isColony = _arg_2;
        }

        private function init():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get cityName():Label
        {
            return (this._1421682026cityName);
        }

        private function set isColony(_arg_1:Boolean):void
        {
            var _local_2:Object = this._680808764isColony;
            if (_local_2 !== _arg_1)
            {
                this._680808764isColony = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isColony", _local_2, _arg_1));
            };
        }

        public function set citytype(_arg_1:Label):void
        {
            var _local_2:Object = this._1420526811citytype;
            if (_local_2 !== _arg_1)
            {
                this._1420526811citytype = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "citytype", _local_2, _arg_1));
            };
        }

        private function _SuzerainInfoTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.isColony) ? "colony" : "suzerain");
            _local_1 = this.colonyBean.cityName;
            _local_1 = (("(" + this.colonyBean.position.replace(".", ",")) + ")");
        }

        public function set coord(_arg_1:Label):void
        {
            var _local_2:Object = this._94845685coord;
            if (_local_2 !== _arg_1)
            {
                this._94845685coord = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "coord", _local_2, _arg_1));
            };
        }

        public function ___SuzerainInfoTooltip_BaseTooltip1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get citytype():Label
        {
            return (this._1420526811citytype);
        }

        [Bindable(event="propertyChange")]
        public function get coord():Label
        {
            return (this._94845685coord);
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }


    }
}//package view.castleList

