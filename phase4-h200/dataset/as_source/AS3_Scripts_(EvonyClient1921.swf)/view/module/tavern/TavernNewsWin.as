// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.tavern.TavernNewsWin

package view.module.tavern
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.SimpleNpcHeroBean;
    import mx.containers.Canvas;
    import mx.controls.DataGrid;
    import com.evony.common.beans.QuestBean;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.collections.ArrayCollection;
    import mx.controls.Image;
    import mx.controls.Text;
    import mx.controls.TextInput;
    import com.evony.common.beans.QuestTypeBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import com.evony.Lang;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import mx.events.ListEvent;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.npchero.NpcHeroListResponse;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.TimerEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.ClassFactory;
    import flash.events.MouseEvent;
    import com.evony.common.module.quest.QuestListResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.Event;
    import com.evony.util.ImageSmooth;
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

    public class TavernNewsWin extends BaseFunctionWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "TavernNewsWin.open";
        public static var instance:TavernNewsWin = new (TavernNewsWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TavernNewsWin_Label1:Label;
        private var _297533621curHeroDetail:SimpleNpcHeroBean;
        private var _1557721601detail2:Canvas;
        private var _1220754915heroDg:DataGrid;
        private var _710707610searchList:DataGrid;
        private var _545394306curQuest:QuestBean;
        private var _1125688922curHero:SimpleNpcHeroBean;
        private var _1226990931acceptTask:Button;
        private var _3016401base:Canvas;
        private var _620285274Instruct:Button;
        private var _946505330viewstack1:ViewStack;
        private var _2023907713heroArray:ArrayCollection;
        private var curSelectQuestTypeIndex:int = 0;
        private var curSelectSubQuestIndex:int = 0;
        private var _1783104352questList:ArrayCollection;
        public var _TavernNewsWin_Button1:Button;
        public var _TavernNewsWin_Button2:Button;
        private var _1455036775heroFilterArray:ArrayCollection;
        private var _738344555iconFile:Image;
        public var _TavernNewsWin_Text7:Text;
        private var _1818043410heroFilter:TextInput;
        private var _2075973533queryDetailBtn:Button;
        public var _TavernNewsWin_Text8:Text;
        private var _1658593671curQuestTypeName:String = "";
        private var _602210084curQuestType:QuestTypeBean;
        private var _554598424HeroInfo:Button;
        private var AllQuestArray:ArrayCollection;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "50";
                            this.left = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 4;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":95,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TavernNewsWin_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"heroFilter"
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_TavernNewsWin_Button1",
                                                "events":{"click":"___TavernNewsWin_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b95"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":20});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_TavernNewsWin_Button2",
                                                "events":{"click":"___TavernNewsWin_Button2_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "2";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"b95",
                                                        "height":25
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"queryDetailBtn",
                                                "events":{"click":"__queryDetailBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "2";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "enabled":false,
                                                        "styleName":"b95",
                                                        "height":25
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"acceptTask",
                                                "events":{"click":"__acceptTask_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "2";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"b95",
                                                        "enabled":false,
                                                        "height":25
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "85";
                            this.left = "430";
                            this.horizontalGap = 4;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"HeroInfo",
                                    "events":{"click":"__HeroInfo_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Hero Info",
                                            "styleName":"b95",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"Instruct",
                                    "events":{"click":"__Instruct_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Instructions",
                                            "styleName":"b95",
                                            "height":25
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "100";
                            this.bottom = "16";
                            this.right = "34";
                            this.left = "280";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"viewstack1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"base",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "40";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "40";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[Hearsay]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"In the Inn, you can get many titbits about folk heroes. The higher level your Inn the more folk heroes can be found in it.",
                                                                                "styleName":"ParamgraphText1",
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.strokeWidth = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":95});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[More Hearsay]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"You can refresh the list of folk heroes   at the expense of  100 Gold.",
                                                                                "styleName":"ParamgraphText1",
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.strokeWidth = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":95});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[Hero Search]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"You can search a hero by typing in his/her name at the expense of 1,000 Gold.",
                                                                                "styleName":"ParamgraphText1",
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.strokeWidth = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":95});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[Enquire Details]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"Spending some game Cents, you will be offered the information of the accurate location of  the hero as well as a Portrait which is necessary to capture the hero. Meanwhile a report will be sent to you.",
                                                                                "styleName":"ParamgraphText1",
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"Notice: You need to use the 'Enquire details' feature again to get the latest location of the hero again in case the hero get captured or moved by other players.",
                                                                                "styleName":"ParamgraphText1",
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.strokeWidth = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":95});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[accept task]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"You can accept Historic Hero hunting quests here. The quest will be displayed in the Hero Quests tab under the Quests Menu once the quest is accepted. You will get some rewards when the quest is complete.",
                                                                                "styleName":"ParamgraphText1",
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"detail2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "40";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                                this.right = "10";
                                                                this.top = "40";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "id":"iconFile",
                                                                        "events":{"complete":"__iconFile_complete"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalCenter = "0";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":63,
                                                                                "height":63
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.strokeWidth = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":95});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[Brief  History]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_TavernNewsWin_Text7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"ParamgraphText1",
                                                                                "percentWidth":95,
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.strokeWidth = 1;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":95});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "text":"[Inn  Keeper]",
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_TavernNewsWin_Text8",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"ParamgraphText1",
                                                                                "percentWidth":95,
                                                                                "selectable":false
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "85";
                            this.verticalGap = 5;
                            this.bottom = "35";
                            this.left = "34";
                            this.right = "550";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"heroDg",
                                    "events":{"itemClick":"__heroDg_itemClick"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "rowCount":10,
                                            "columns":[_TavernNewsWin_DataGridColumn1_c()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"searchList",
                                    "events":{"itemClick":"__searchList_itemClick"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":115,
                                            "percentWidth":100,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "columns":[_TavernNewsWin_DataGridColumn2_c()]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var RoutinQuestArray:ArrayCollection = new ArrayCollection();
        private var DailyQuestArray:ArrayCollection = new ArrayCollection();
        private var _1257442951eachTargetArray:ArrayCollection = new ArrayCollection([{
            "name":Lang.msg("日常任务领取描述"),
            "finished":null
        }]);
        private var heroListTimer:Timer = new Timer(900000, 0);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TavernNewsWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___TavernNewsWin_BaseFunctionWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___TavernNewsWin_BaseFunctionWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TavernNewsWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get detail2():Canvas
        {
            return (this._1557721601detail2);
        }

        public function set detail2(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1557721601detail2;
            if (_local_2 !== _arg_1)
            {
                this._1557721601detail2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "detail2", _local_2, _arg_1));
            };
        }

        private function surequeryDetail(_arg_1:Boolean):void
        {
            if (_arg_1 == true)
            {
                ActionFactory.getInstance().getNpcHeroCommand().getNpcHeroInfroByID(this.curHero.npcid, Context.getInstance().getCurCastle().id);
            };
        }

        private function _TavernNewsWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("市井传闻");
            _local_1 = Lang.msg("打听消息");
            _local_1 = Lang.msg("搜索");
            _local_1 = Lang.msg("更多传闻");
            _local_1 = Lang.msg("询问详情");
            _local_1 = Lang.msg("领取任务");
            _local_1 = this.curHeroDetail.logourl;
            _local_1 = this.curHeroDetail.introduce;
            _local_1 = this.curHeroDetail.introduce2;
            _local_1 = this.heroArray;
            _local_1 = this.heroFilterArray;
        }

        private function onChangeHero(_arg_1:ListEvent):void
        {
            this.curHeroDetail = (_arg_1.itemRenderer.data as SimpleNpcHeroBean);
            this.curHero = this.curHeroDetail;
            this.viewstack1.selectedChild = this.detail2;
            trace("-------------------------------------------------------------------------");
            trace(this.curHero.name);
            queryDetailBtn.enabled = true;
            acceptTask.enabled = true;
        }

        private function set curQuest(_arg_1:QuestBean):void
        {
            var _local_2:Object = this._545394306curQuest;
            if (_local_2 !== _arg_1)
            {
                this._545394306curQuest = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curQuest", _local_2, _arg_1));
            };
        }

        public function ___TavernNewsWin_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set curQuestTypeName(_arg_1:String):void
        {
            var _local_2:Object = this._1658593671curQuestTypeName;
            if (_local_2 !== _arg_1)
            {
                this._1658593671curQuestTypeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curQuestTypeName", _local_2, _arg_1));
            };
        }

        private function onHeroListFilter(_arg_1:NpcHeroListResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.heroFilterArray = _arg_1.simpleNpcHerosArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.NPCHERO_GET_NPC_HEROS_LIST, onHeroList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.NPCHERO_GET_NPC_HEROS_LIST_BY_MONEY, onHeroList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.NPCHERO_GET_NPC_HEROS_LIST_BY_FILTER, onHeroListFilter);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.NPCHERO_GET_NPC_HERO_INFRO_BY_I_D, onHeroDetail);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_ACCEPT, onAcceptQuest);
            this.refresh();
            heroListTimer.addEventListener(TimerEvent.TIMER, heroListTimeHandle);
            heroListTimer.start();
        }

        [Bindable(event="propertyChange")]
        public function get heroFilter():TextInput
        {
            return (this._1818043410heroFilter);
        }

        private function set eachTargetArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1257442951eachTargetArray;
            if (_local_2 !== _arg_1)
            {
                this._1257442951eachTargetArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eachTargetArray", _local_2, _arg_1));
            };
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroDg():DataGrid
        {
            return (this._1220754915heroDg);
        }

        private function _TavernNewsWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Hearsay";
            _local_1.itemRenderer = _TavernNewsWin_ClassFactory1_c();
            return (_local_1);
        }

        private function onHeroDetail(_arg_1:NpcHeroListResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.curHeroDetail = (_arg_1.simpleNpcHerosArray[0] as SimpleNpcHeroBean);
                this.viewstack1.selectedChild = this.detail2;
                this.refresh();
                if (this.heroFilter.text == "")
                {
                    return;
                };
                ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByFilter(heroFilter.text.toString(), Context.getInstance().getCurCastle().id);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function heroListTimeHandle(_arg_1:TimerEvent):void
        {
            ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosList(Context.getInstance().getCurCastle().id);
        }

        public function set iconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        private function _TavernNewsWin_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TavernNewsWin_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function queryDetail():void
        {
            var _local_1:String = this.curHero.introduce2;
            if (_local_1.indexOf("According to") == 0)
            {
                AlertWin.show((("You have already bought the details of " + this.curHero.name) + ".  Do you want to get his latest co-ordinate by spending 10 cents again?"), surequeryDetail, "Yes", "No", null);
            }
            else
            {
                AlertWin.show(Lang.msg("详细询问要给10 cents的小费，您确定吗？"), surequeryDetail, "Ok", "Cancel", null);
            };
        }

        public function set heroDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1220754915heroDg;
            if (_local_2 !== _arg_1)
            {
                this._1220754915heroDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroDg", _local_2, _arg_1));
            };
        }

        public function set heroFilter(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1818043410heroFilter;
            if (_local_2 !== _arg_1)
            {
                this._1818043410heroFilter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroFilter", _local_2, _arg_1));
            };
        }

        private function set questList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1783104352questList;
            if (_local_2 !== _arg_1)
            {
                this._1783104352questList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questList", _local_2, _arg_1));
            };
        }

        private function showInstructions(_arg_1:int):void
        {
            if (_arg_1 == 1)
            {
                this.viewstack1.selectedChild = this.base;
            }
            else
            {
                if (this.curHeroDetail != null)
                {
                    this.viewstack1.selectedChild = this.detail2;
                };
            };
        }

        public function __Instruct_click(_arg_1:MouseEvent):void
        {
            showInstructions(1);
        }

        [Bindable(event="propertyChange")]
        private function get curHeroDetail():SimpleNpcHeroBean
        {
            return (this._297533621curHeroDetail);
        }

        public function __HeroInfo_click(_arg_1:MouseEvent):void
        {
            showInstructions(0);
        }

        public function __acceptTask_click(_arg_1:MouseEvent):void
        {
            award();
        }

        [Bindable(event="propertyChange")]
        public function get Instruct():Button
        {
            return (this._620285274Instruct);
        }

        private function onAcceptQuest(_arg_1:QuestListResponse):void
        {
            AlertWin.show(_arg_1.errorMsg);
        }

        private function award():void
        {
            ActionFactory.getInstance().getQuestCommands().accept(this.curHero.npcid, Context.getInstance().getCurCastle().id);
        }

        public function set acceptTask(_arg_1:Button):void
        {
            var _local_2:Object = this._1226990931acceptTask;
            if (_local_2 !== _arg_1)
            {
                this._1226990931acceptTask = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "acceptTask", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get queryDetailBtn():Button
        {
            return (this._2075973533queryDetailBtn);
        }

        [Bindable(event="propertyChange")]
        public function get searchList():DataGrid
        {
            return (this._710707610searchList);
        }

        [Bindable(event="propertyChange")]
        private function get heroFilterArray():ArrayCollection
        {
            return (this._1455036775heroFilterArray);
        }

        [Bindable(event="propertyChange")]
        private function get curHero():SimpleNpcHeroBean
        {
            return (this._1125688922curHero);
        }

        public function __heroDg_itemClick(_arg_1:ListEvent):void
        {
            onChangeHero(_arg_1);
        }

        private function _TavernNewsWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TavernNewsWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___TavernNewsWin_Button1_click(_arg_1:MouseEvent):void
        {
            searchHero();
        }

        [Bindable(event="propertyChange")]
        private function get heroArray():ArrayCollection
        {
            return (this._2023907713heroArray);
        }

        [Bindable(event="propertyChange")]
        private function get curQuest():QuestBean
        {
            return (this._545394306curQuest);
        }

        public function __searchList_itemClick(_arg_1:ListEvent):void
        {
            onChangeHero(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get curQuestTypeName():String
        {
            return (this._1658593671curQuestTypeName);
        }

        public function __queryDetailBtn_click(_arg_1:MouseEvent):void
        {
            queryDetail();
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        override public function initialize():void
        {
            var target:TavernNewsWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TavernNewsWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_tavern_TavernNewsWinWatcherSetupUtil");
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
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        private function set curHeroDetail(_arg_1:SimpleNpcHeroBean):void
        {
            var _local_2:Object = this._297533621curHeroDetail;
            if (_local_2 !== _arg_1)
            {
                this._297533621curHeroDetail = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curHeroDetail", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get eachTargetArray():ArrayCollection
        {
            return (this._1257442951eachTargetArray);
        }

        public function set base(_arg_1:Canvas):void
        {
            var _local_2:Object = this._3016401base;
            if (_local_2 !== _arg_1)
            {
                this._3016401base = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "base", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get questList():ArrayCollection
        {
            return (this._1783104352questList);
        }

        [Bindable(event="propertyChange")]
        public function get acceptTask():Button
        {
            return (this._1226990931acceptTask);
        }

        private function sureSearchHero(_arg_1:Boolean):void
        {
            if (_arg_1 == true)
            {
                if (this.heroFilter.text == "")
                {
                    AlertWin.show(Lang.msg("输入不能为空"), null);
                    return;
                };
                ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByFilter(heroFilter.text.toString(), Context.getInstance().getCurCastle().id);
            };
        }

        private function set curQuestType(_arg_1:QuestTypeBean):void
        {
            var _local_2:Object = this._602210084curQuestType;
            if (_local_2 !== _arg_1)
            {
                this._602210084curQuestType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curQuestType", _local_2, _arg_1));
            };
        }

        public function set Instruct(_arg_1:Button):void
        {
            var _local_2:Object = this._620285274Instruct;
            if (_local_2 !== _arg_1)
            {
                this._620285274Instruct = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Instruct", _local_2, _arg_1));
            };
        }

        public function ___TavernNewsWin_Button2_click(_arg_1:MouseEvent):void
        {
            showMoreHeros();
        }

        private function _TavernNewsWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("市井传闻");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("打听消息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TavernNewsWin_Label1.text = _arg_1;
            }, "_TavernNewsWin_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("搜索");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TavernNewsWin_Button1.label = _arg_1;
            }, "_TavernNewsWin_Button1.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更多传闻");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TavernNewsWin_Button2.label = _arg_1;
            }, "_TavernNewsWin_Button2.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("询问详情");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                queryDetailBtn.label = _arg_1;
            }, "queryDetailBtn.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("领取任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                acceptTask.label = _arg_1;
            }, "acceptTask.label");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.curHeroDetail.logourl);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curHeroDetail.introduce;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TavernNewsWin_Text7.text = _arg_1;
            }, "_TavernNewsWin_Text7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curHeroDetail.introduce2;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TavernNewsWin_Text8.text = _arg_1;
            }, "_TavernNewsWin_Text8.text");
            result[8] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.heroArray);
            }, function (_arg_1:Object):void
            {
                heroDg.dataProvider = _arg_1;
            }, "heroDg.dataProvider");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.heroFilterArray);
            }, function (_arg_1:Object):void
            {
                searchList.dataProvider = _arg_1;
            }, "searchList.dataProvider");
            result[10] = binding;
            return (result);
        }

        private function onHeroList(_arg_1:NpcHeroListResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.heroArray = _arg_1.simpleNpcHerosArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___TavernNewsWin_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function searchHero():void
        {
            AlertWin.show(Lang.msg("搜索指定名将消息要给1000黄金的小费，您确定吗？"), sureSearchHero, "Ok", "Cancel", null);
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function set heroFilterArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1455036775heroFilterArray;
            if (_local_2 !== _arg_1)
            {
                this._1455036775heroFilterArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroFilterArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get base():Canvas
        {
            return (this._3016401base);
        }

        public function set searchList(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._710707610searchList;
            if (_local_2 !== _arg_1)
            {
                this._710707610searchList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "searchList", _local_2, _arg_1));
            };
        }

        public function set queryDetailBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2075973533queryDetailBtn;
            if (_local_2 !== _arg_1)
            {
                this._2075973533queryDetailBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queryDetailBtn", _local_2, _arg_1));
            };
        }

        private function set curHero(_arg_1:SimpleNpcHeroBean):void
        {
            var _local_2:Object = this._1125688922curHero;
            if (_local_2 !== _arg_1)
            {
                this._1125688922curHero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curHero", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosList(Context.getInstance().getCurCastle().id);
        }

        [Bindable(event="propertyChange")]
        private function get curQuestType():QuestTypeBean
        {
            return (this._602210084curQuestType);
        }

        private function _TavernNewsWin_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Search Result";
            _local_1.itemRenderer = _TavernNewsWin_ClassFactory2_c();
            return (_local_1);
        }

        private function showMoreHeros():void
        {
            AlertWin.show(Lang.msg("打听更多传闻要给100黄金的小费，您确定吗？"), sureshowMoreHeros, "Ok", "Cancel", null);
        }

        [Bindable(event="propertyChange")]
        public function get HeroInfo():Button
        {
            return (this._554598424HeroInfo);
        }

        private function sureshowMoreHeros(_arg_1:Boolean):void
        {
            if (_arg_1 == true)
            {
                ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByMoney(Context.getInstance().getCurCastle().id);
            };
        }

        override public function destroy():void
        {
            heroListTimer.stop();
        }

        public function set HeroInfo(_arg_1:Button):void
        {
            var _local_2:Object = this._554598424HeroInfo;
            if (_local_2 !== _arg_1)
            {
                this._554598424HeroInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "HeroInfo", _local_2, _arg_1));
            };
        }

        private function set heroArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2023907713heroArray;
            if (_local_2 !== _arg_1)
            {
                this._2023907713heroArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroArray", _local_2, _arg_1));
            };
        }


    }
}//package view.module.tavern

