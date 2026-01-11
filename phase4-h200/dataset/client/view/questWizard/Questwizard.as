// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.questWizard.Questwizard

package view.questWizard
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.Text;
    import mx.controls.Label;
    import com.evony.common.beans.QuestBean;
    import com.evony.common.beans.QuestTypeBean;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.Context;
    import com.evony.common.module.quest.QuestListResponse;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.quest.QuestTypeResponse;
    import view.AllWindows;
    import view.module.quest.QuestWin;
    import view.MainWin;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import flash.filters.GlowFilter;
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

    public class Questwizard extends Canvas implements IBindingClient 
    {

        public static var instance:Questwizard = new (Questwizard)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _645310820SetType:int;
        private var bSend:Boolean = false;
        private var questList:ArrayCollection = null;
        private var _220778640QuestInfo:Text;
        private var _67988384GOALS:Label;
        public var bopen:Boolean = true;
        private var _78361854Qtext:String = " ";
        public var QuestTypeid:int;
        private var HeroQuestArray:ArrayCollection = null;
        public var curQuestBean:QuestBean;
        private var RoutinQuestArray:ArrayCollection = null;
        private var QuestTypeList:Array = null;
        public var curQuestType:QuestTypeBean = null;
        private var questGuideStepList:Array;
        public var Questtype:String = null;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":250,
                    "height":200,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"GOALS",
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.fontSize = 15;
                            this.color = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"GOALS",
                                "width":200,
                                "height":40
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"QuestInfo",
                        "events":{"click":"__QuestInfo_click"},
                        "stylesFactory":function ():void
                        {
                            this.color = 0xFFFFFF;
                            this.fontSize = 14;
                            this.top = "60";
                            this.textDecoration = "underline";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseChildren":false,
                                "useHandCursor":true,
                                "percentWidth":100,
                                "height":40,
                                "buttonMode":true
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

        public function Questwizard()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 0;
            };
            this.width = 250;
            this.height = 200;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___Questwizard_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Questwizard._watcherSetupUtil = _arg_1;
        }


        private function onQuestList(_arg_1:QuestListResponse):void
        {
            this.questList = _arg_1.questsArray;
            if (Context.getInstance().need_QuestGuid)
            {
                SetSmallPoint(questList);
            };
        }

        public function set Qtext(_arg_1:String):void
        {
            var _local_2:Object = this._78361854Qtext;
            if (_local_2 !== _arg_1)
            {
                this._78361854Qtext = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Qtext", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get Qtext():String
        {
            return (this._78361854Qtext);
        }

        public function GetQuestList():void
        {
            if (Context.getInstance().need_QuestGuid)
            {
                bopen = true;
                ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 1);
            };
        }

        override public function initialize():void
        {
            var target:Questwizard;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Questwizard_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_questWizard_QuestwizardWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        private function get SetType():int
        {
            return (this._645310820SetType);
        }

        private function onQuestType(_arg_1:QuestTypeResponse):void
        {
            var _local_2:ArrayCollection = _arg_1.typesArray;
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:int = QuestTypeBean(_local_2[0]).mainId;
            if (_local_3 == 1)
            {
                this.RoutinQuestArray = _arg_1.typesArray;
                if (Context.getInstance().need_QuestGuid)
                {
                    checkQuestTypeList();
                };
            }
            else
            {
                if (_local_3 == 4)
                {
                    this.HeroQuestArray = _arg_1.typesArray;
                };
            };
        }

        private function showQuestmain():void
        {
            AllWindows.switchToFuncWindow(QuestWin.EVENT_SHOW);
            MainWin.instance.setMyQuestBtnTooltipVisible(false);
        }

        private function init():void
        {
            if (Context.getInstance().need_QuestGuid)
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_QUEST_LIST, onQuestList);
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_QUEST_TYPE, onQuestType);
            };
            instance = this;
        }

        public function setOverText():void
        {
        }

        private function setOverBean(_arg_1:QuestBean):void
        {
            var _local_2:Object = GuideData.getInstance().getValue(_arg_1.questId);
            if (_local_2 != null)
            {
                this.QuestInfo.htmlText = _local_2.otitle;
            };
        }

        [Bindable(event="propertyChange")]
        public function get GOALS():Label
        {
            return (this._67988384GOALS);
        }

        private function checkQestFinish():void
        {
        }

        public function SetSmallPoint(_arg_1:ArrayCollection):void
        {
            var _local_3:QuestBean;
            var _local_2:int;
            for each (_local_3 in _arg_1)
            {
                if (!_local_3.isFinish)
                {
                    if (_local_3.recommend)
                    {
                        AllWindows.instance.qusetWinVs.SmallArrowPoints(_local_2, _local_3);
                        this.setBean(_local_3);
                    };
                }
                else
                {
                    this.setOverBean(_local_3);
                };
                _local_2 = (_local_2 + 1);
            };
        }

        public function set QuestInfo(_arg_1:Text):void
        {
            var _local_2:Object = this._220778640QuestInfo;
            if (_local_2 !== _arg_1)
            {
                this._220778640QuestInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "QuestInfo", _local_2, _arg_1));
            };
        }

        private function setBean(_arg_1:QuestBean):void
        {
            var _local_2:Object = GuideData.getInstance().getValue(_arg_1.questId);
            if (_local_2 != null)
            {
                this.QuestInfo.htmlText = _local_2.title;
            };
        }

        public function __QuestInfo_click(_arg_1:MouseEvent):void
        {
            showQuestmain();
        }

        [Bindable(event="propertyChange")]
        public function get QuestInfo():Text
        {
            return (this._220778640QuestInfo);
        }

        private function set SetType(_arg_1:int):void
        {
            var _local_2:Object = this._645310820SetType;
            if (_local_2 !== _arg_1)
            {
                this._645310820SetType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SetType", _local_2, _arg_1));
            };
        }

        public function set GOALS(_arg_1:Label):void
        {
            var _local_2:Object = this._67988384GOALS;
            if (_local_2 !== _arg_1)
            {
                this._67988384GOALS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "GOALS", _local_2, _arg_1));
            };
        }

        public function ___Questwizard_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function checkQuestTypeList():void
        {
            var _local_2:QuestTypeBean;
            var _local_1:int;
            for each (_local_2 in this.RoutinQuestArray)
            {
                if (_local_2.recommend)
                {
                    if (_local_2 != null)
                    {
                        AllWindows.instance.qusetWinVs.ArrowPoints(_local_1);
                        this.curQuestType = _local_2;
                        if (this.bopen)
                        {
                            ActionFactory.getInstance().getQuestCommands().getQuestList(Context.getInstance().getCurCastle().id, _local_2.typeId);
                        };
                        Context.getInstance().need_QuestGuid = true;
                    };
                    return;
                };
                _local_1 = (_local_1 + 1);
            };
            Context.getInstance().need_QuestGuid = false;
        }

        private function _Questwizard_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = [new GlowFilter(0, 1, 6, 6, 8, 1, false, false)];
            _local_1 = [new GlowFilter(0, 1, 6, 6, 8, 1, false, false)];
        }

        private function _Questwizard_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0, 1, 6, 6, 8, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                GOALS.filters = _arg_1;
            }, "GOALS.filters");
            result[0] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0, 1, 6, 6, 8, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                QuestInfo.filters = _arg_1;
            }, "QuestInfo.filters");
            result[1] = binding;
            return (result);
        }


    }
}//package view.questWizard

