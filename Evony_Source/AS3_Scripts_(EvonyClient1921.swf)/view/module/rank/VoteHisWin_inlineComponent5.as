// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.VoteHisWin_inlineComponent5

package view.module.rank
{
    import mx.controls.Label;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.util.UIUtil;
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

    public class VoteHisWin_inlineComponent5 extends Label implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _88844982outerDocument:VoteHisWin;

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function VoteHisWin_inlineComponent5()
        {
            super();
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.fontFamily = "DejaVuSans";
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            VoteHisWin_inlineComponent5._watcherSetupUtil = _arg_1;
        }


        public function set outerDocument(_arg_1:VoteHisWin):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _VoteHisWin_inlineComponent5_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(data.honor);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.text = _arg_1;
            }, "this.text");
            result[0] = binding;
            binding = new Binding(this, function ():uint
            {
                return ((outerDocument.myStyleName(outerDocument.isExactMatch, data.userName, data.ranking)) ? outerDocument.focusColor : outerDocument.normalColor);
            }, function (_arg_1:uint):void
            {
                this.setStyle("color", _arg_1);
            }, "this.color");
            result[1] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:VoteHisWin_inlineComponent5;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _VoteHisWin_inlineComponent5_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_VoteHisWin_inlineComponent5WatcherSetupUtil");
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

        private function _VoteHisWin_inlineComponent5_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = UIUtil.FormatInt(data.honor);
            _local_1 = ((outerDocument.myStyleName(outerDocument.isExactMatch, data.userName, data.ranking)) ? outerDocument.focusColor : outerDocument.normalColor);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():VoteHisWin
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.rank

