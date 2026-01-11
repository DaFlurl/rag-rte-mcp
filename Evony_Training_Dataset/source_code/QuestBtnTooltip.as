// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.QuestBtnTooltip

package view.module.quest
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.EvonyImage;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Context;
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

    public class QuestBtnTooltip extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _QuestBtnTooltip_TextArea1:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":333,
                    "height":106,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@questTooltip.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_QuestBtnTooltip_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.left = "15";
                            this.right = "10";
                            this.top = "10";
                            this.bottom = "15";
                            this.textAlign = "left";
                            this.backgroundAlpha = 0;
                            this.borderStyle = "none";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"NoticeForTootip",
                                "selectable":false
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

        public function QuestBtnTooltip()
        {
            mx_internal::_document = this;
            this.width = 333;
            this.height = 106;
            this.addEventListener("creationComplete", ___QuestBtnTooltip_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            QuestBtnTooltip._watcherSetupUtil = _arg_1;
        }


        public function ___QuestBtnTooltip_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _QuestBtnTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("任务按钮提示");
        }

        override public function initialize():void
        {
            var target:QuestBtnTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _QuestBtnTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_quest_QuestBtnTooltipWatcherSetupUtil");
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

        private function _QuestBtnTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务按钮提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestBtnTooltip_TextArea1.text = _arg_1;
            }, "_QuestBtnTooltip_TextArea1.text");
            result[0] = binding;
            return (result);
        }

        private function init():void
        {
            if (!Context.getInstance().userIsFirstLogin)
            {
                this.visible = false;
            };
        }


    }
}//package view.module.quest

