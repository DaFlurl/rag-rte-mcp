// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.QuestWin_inlineComponent1

package view.module.quest
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
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

    public class QuestWin_inlineComponent1 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _88844982outerDocument:QuestWin;
        private var _1201704951finishedImage:Image;
        public var _QuestWin_inlineComponent1_Text1:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Text,
                        "id":"_QuestWin_inlineComponent1_Text1",
                        "stylesFactory":function ():void
                        {
                            this.color = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "maxWidth":502,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"finishedImage",
                        "events":{"creationComplete":"__finishedImage_creationComplete"}
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function QuestWin_inlineComponent1()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalGap = 0;
            };
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.percentWidth = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            QuestWin_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        private function _QuestWin_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_inlineComponent1_Text1.text = _arg_1;
            }, "_QuestWin_inlineComponent1_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((data.finished == null) ? finishedImage.includeInLayout = false : ((data.finished) ? outerDocument.getFinishIcon() : outerDocument.getUnfinishIcon()));
            }, function (_arg_1:Object):void
            {
                finishedImage.source = _arg_1;
            }, "finishedImage.source");
            result[1] = binding;
            return (result);
        }

        public function set outerDocument(_arg_1:QuestWin):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get finishedImage():Image
        {
            return (this._1201704951finishedImage);
        }

        public function __finishedImage_creationComplete(_arg_1:FlexEvent):void
        {
            outerDocument.onCreationComplete(_arg_1);
        }

        public function set finishedImage(_arg_1:Image):void
        {
            var _local_2:Object = this._1201704951finishedImage;
            if (_local_2 !== _arg_1)
            {
                this._1201704951finishedImage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finishedImage", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:QuestWin_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _QuestWin_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_quest_QuestWin_inlineComponent1WatcherSetupUtil");
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

        private function _QuestWin_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.name;
            _local_1 = ((data.finished == null) ? finishedImage.includeInLayout = false : ((data.finished) ? outerDocument.getFinishIcon() : outerDocument.getUnfinishIcon()));
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():QuestWin
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.quest

