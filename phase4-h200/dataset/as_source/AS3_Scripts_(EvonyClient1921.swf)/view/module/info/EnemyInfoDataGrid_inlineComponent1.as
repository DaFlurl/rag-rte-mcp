// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.EnemyInfoDataGrid_inlineComponent1

package view.module.info
{
    import mx.containers.VBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.CheckBox;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class EnemyInfoDataGrid_inlineComponent1 extends VBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1361380539chkBox:CheckBox;
        private var _88844982outerDocument:EnemyInfoDataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"chkBox",
                        "events":{"click":"__chkBox_click"}
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EnemyInfoDataGrid_inlineComponent1()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "center";
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EnemyInfoDataGrid_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get outerDocument():EnemyInfoDataGrid
        {
            return (this._88844982outerDocument);
        }

        [Bindable(event="propertyChange")]
        public function get chkBox():CheckBox
        {
            return (this._1361380539chkBox);
        }

        public function __chkBox_click(_arg_1:MouseEvent):void
        {
            parentDocument.changeIgnoreList(data);
        }

        override public function initialize():void
        {
            var target:EnemyInfoDataGrid_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EnemyInfoDataGrid_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_EnemyInfoDataGrid_inlineComponent1WatcherSetupUtil");
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

        public function set outerDocument(_arg_1:EnemyInfoDataGrid):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _EnemyInfoDataGrid_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (data.selected);
            }, function (_arg_1:Boolean):void
            {
                chkBox.selected = _arg_1;
            }, "chkBox.selected");
            result[0] = binding;
            return (result);
        }

        public function set chkBox(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1361380539chkBox;
            if (_local_2 !== _arg_1)
            {
                this._1361380539chkBox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chkBox", _local_2, _arg_1));
            };
        }

        private function _EnemyInfoDataGrid_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.selected;
        }


    }
}//package view.module.info

