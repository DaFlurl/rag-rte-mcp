// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AllCastleView_inlineComponent2

package view.module.office
{
    import mx.controls.Label;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.core.mx_internal;
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

    public class AllCastleView_inlineComponent2 extends Label implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _88844982outerDocument:AllCastleView;

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllCastleView_inlineComponent2()
        {
            super();
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.fontSize = 12;
            };
            this.addEventListener("click", ___AllCastleView_inlineComponent2_Label1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllCastleView_inlineComponent2._watcherSetupUtil = _arg_1;
        }


        public function set outerDocument(_arg_1:AllCastleView):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _AllCastleView_inlineComponent2_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.hero;
        }

        public function ___AllCastleView_inlineComponent2_Label1_click(_arg_1:MouseEvent):void
        {
            parentDocument.seeAbout(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():AllCastleView
        {
            return (this._88844982outerDocument);
        }

        private function _AllCastleView_inlineComponent2_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.hero;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.text = _arg_1;
            }, "this.text");
            result[0] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:AllCastleView_inlineComponent2;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _AllCastleView_inlineComponent2_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AllCastleView_inlineComponent2WatcherSetupUtil");
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


    }
}//package view.module.office

