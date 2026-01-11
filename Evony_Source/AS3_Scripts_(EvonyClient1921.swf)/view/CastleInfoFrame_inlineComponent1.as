// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.CastleInfoFrame_inlineComponent1

package view
{
    import view.castleInfo.Heros;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
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

    public class CastleInfoFrame_inlineComponent1 extends Heros implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _88844982outerDocument:CastleInfoFrame;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Heros});
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleInfoFrame_inlineComponent1()
        {
            mx_internal::_document = this;
            this.addEventListener("click", ___CastleInfoFrame_inlineComponent1_Heros1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleInfoFrame_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get outerDocument():CastleInfoFrame
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            var target:CastleInfoFrame_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleInfoFrame_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_CastleInfoFrame_inlineComponent1WatcherSetupUtil");
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

        private function _CastleInfoFrame_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (data);
            }, function (_arg_1:Object):void
            {
                this.hero = _arg_1;
            }, "this.hero");
            result[0] = binding;
            return (result);
        }

        public function set outerDocument(_arg_1:CastleInfoFrame):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _CastleInfoFrame_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data;
        }

        public function ___CastleInfoFrame_inlineComponent1_Heros1_click(_arg_1:MouseEvent):void
        {
            outerDocument.showHeroInfo(data);
        }


    }
}//package view

