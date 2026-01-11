// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScBuilding

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.eum.BuildingEumDefine;
    import flash.utils.getDefinitionByName;
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

    public class ScBuilding extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1003243718textarea:Text;
        private var _585989564_typeName:String;
        private var _104347194myNum:String;
        public var _ScBuilding_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":660,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScBuilding_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":140});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"textarea",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"normalColor",
                                                        "percentWidth":100
                                                    });
                                                }
                                            })]
                                        });
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

        public function ScBuilding()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.width = 660;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ScBuilding._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get textarea():Text
        {
            return (this._1003243718textarea);
        }

        private function _ScBuilding_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._typeName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScBuilding_Label1.text = _arg_1;
            }, "_ScBuilding_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.myNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                textarea.text = _arg_1;
            }, "textarea.text");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get _typeName():String
        {
            return (this._585989564_typeName);
        }

        [Bindable(event="propertyChange")]
        private function get myNum():String
        {
            return (this._104347194myNum);
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
        }

        public function set num(_arg_1:String):void
        {
            this.myNum = _arg_1;
        }

        override public function initialize():void
        {
            var target:ScBuilding;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ScBuilding_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_ScBuildingWatcherSetupUtil");
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

        public function set textarea(_arg_1:Text):void
        {
            var _local_2:Object = this._1003243718textarea;
            if (_local_2 !== _arg_1)
            {
                this._1003243718textarea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textarea", _local_2, _arg_1));
            };
        }

        private function _ScBuilding_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._typeName;
            _local_1 = this.myNum;
        }

        private function set myNum(_arg_1:String):void
        {
            var _local_2:Object = this._104347194myNum;
            if (_local_2 !== _arg_1)
            {
                this._104347194myNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myNum", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

