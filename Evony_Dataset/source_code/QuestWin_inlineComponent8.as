// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.QuestWin_inlineComponent8

package view.module.quest
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import com.evony.util.EvonyImage;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class QuestWin_inlineComponent8 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _QuestWin_inlineComponent8_Label1:Label;
        public var _QuestWin_inlineComponent8_Image1:Image;
        public var _QuestWin_inlineComponent8_EvonyImage2:EvonyImage;
        public var _QuestWin_inlineComponent8_EvonyImage1:EvonyImage;
        private var _88844982outerDocument:QuestWin;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_QuestWin_inlineComponent8_Label1",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"height":20});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_QuestWin_inlineComponent8_Image1",
                        "events":{"creationComplete":"___QuestWin_inlineComponent8_Image1_creationComplete"}
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "id":"_QuestWin_inlineComponent8_EvonyImage1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/icon/Age2Quest.png",
                                "width":43,
                                "height":20
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":26,
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_QuestWin_inlineComponent8_EvonyImage2",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/point.png",
                                            "percentHeight":100
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function QuestWin_inlineComponent8()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "left";
                this.left = "5";
                this.verticalAlign = "bottom";
            };
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            QuestWin_inlineComponent8._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get outerDocument():QuestWin
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            var target:QuestWin_inlineComponent8;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _QuestWin_inlineComponent8_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_quest_QuestWin_inlineComponent8WatcherSetupUtil");
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

        private function _QuestWin_inlineComponent8_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_inlineComponent8_Label1.text = _arg_1;
            }, "_QuestWin_inlineComponent8_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (outerDocument.getFinishIcon());
            }, function (_arg_1:Object):void
            {
                _QuestWin_inlineComponent8_Image1.source = _arg_1;
            }, "_QuestWin_inlineComponent8_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.isFinish) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_inlineComponent8_Image1.includeInLayout = _arg_1;
            }, "_QuestWin_inlineComponent8_Image1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.isFinish) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_inlineComponent8_Image1.visible = _arg_1;
            }, "_QuestWin_inlineComponent8_Image1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.version == 2) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_inlineComponent8_EvonyImage1.includeInLayout = _arg_1;
            }, "_QuestWin_inlineComponent8_EvonyImage1.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.version == 2) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_inlineComponent8_EvonyImage1.visible = _arg_1;
            }, "_QuestWin_inlineComponent8_EvonyImage1.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.recommend) && (outerDocument.GetQuestGuide()));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_inlineComponent8_EvonyImage2.includeInLayout = _arg_1;
            }, "_QuestWin_inlineComponent8_EvonyImage2.includeInLayout");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.recommend) && (outerDocument.GetQuestGuide()));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_inlineComponent8_EvonyImage2.visible = _arg_1;
            }, "_QuestWin_inlineComponent8_EvonyImage2.visible");
            result[7] = binding;
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

        public function ___QuestWin_inlineComponent8_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            outerDocument.onCreationComplete(_arg_1);
        }

        private function _QuestWin_inlineComponent8_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.name;
            _local_1 = outerDocument.getFinishIcon();
            _local_1 = ((data.isFinish) ? true : false);
            _local_1 = ((data.isFinish) ? true : false);
            _local_1 = ((data.version == 2) ? true : false);
            _local_1 = ((data.version == 2) ? true : false);
            _local_1 = ((data.recommend) && (outerDocument.GetQuestGuide()));
            _local_1 = ((data.recommend) && (outerDocument.GetQuestGuide()));
        }


    }
}//package view.module.quest

