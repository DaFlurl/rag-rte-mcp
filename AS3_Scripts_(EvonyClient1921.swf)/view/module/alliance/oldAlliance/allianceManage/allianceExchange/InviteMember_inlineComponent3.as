// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.InviteMember_inlineComponent3

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import view.module.office.CheckOutButton;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class InviteMember_inlineComponent3 extends CheckOutButton implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _88844982outerDocument:InviteMember;

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function InviteMember_inlineComponent3()
        {
            this.addEventListener("click", ___InviteMember_inlineComponent3_CheckOutButton1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            InviteMember_inlineComponent3._watcherSetupUtil = _arg_1;
        }


        private function _InviteMember_inlineComponent3_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = outerDocument.cancelStr;
        }

        public function set outerDocument(_arg_1:InviteMember):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        public function ___InviteMember_inlineComponent3_CheckOutButton1_click(_arg_1:MouseEvent):void
        {
            outerDocument.showMembersMsg(data);
        }

        override public function initialize():void
        {
            var target:InviteMember_inlineComponent3;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _InviteMember_inlineComponent3_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_InviteMember_inlineComponent3WatcherSetupUtil");
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

        private function _InviteMember_inlineComponent3_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = outerDocument.cancelStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.label = _arg_1;
            }, "this.label");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():InviteMember
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

