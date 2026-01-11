package autoevony.gui
{
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.collections.ArrayList;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class TopInfo extends VBox implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const AllianceLv1:Class = TopInfo_AllianceLv1;
      
      private static const AllianceLv2:Class = TopInfo_AllianceLv2;
      
      private static const AllianceLv3:Class = TopInfo_AllianceLv3;
      
      private static const AllianceLv4:Class = TopInfo_AllianceLv4;
      
      private static const AllianceLv5:Class = TopInfo_AllianceLv5;
      
      private var _1019789636office:String;
      
      private var _1806944311alliance:String;
      
      private var _99462250honor:String;
      
      private var _embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973:Class;
      
      private var _3506294role:String;
      
      public var _TopInfo_Label1:Label;
      
      public var _TopInfo_Label2:Label;
      
      public var _TopInfo_Label3:Label;
      
      public var _TopInfo_Label4:Label;
      
      public var _TopInfo_Label5:Label;
      
      public var _TopInfo_Label6:Label;
      
      public var _TopInfo_Label7:Label;
      
      public var _TopInfo_Label9:Label;
      
      public var _TopInfo_Label8:Label;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_mxml_autoevony_gui_images_rank_png_1843179317:Class;
      
      private var _1569142294allianceLvLArr:ArrayList;
      
      private var _embed_mxml_autoevony_gui_images_title_png_2018272843:Class;
      
      private var _embed_mxml_autoevony_gui_images_gameCoins_png_216677973:Class;
      
      private var _3172656gift:String;
      
      private var _embed_mxml_autoevony_gui_images_gift_png_2082389813:Class;
      
      mx_internal var _watchers:Array;
      
      private var _embed_mxml_autoevony_gui_images_prestige_png_988543979:Class;
      
      private var _embed_mxml_autoevony_gui_images_alliance_png_1159272469:Class;
      
      public var _TopInfo_Image7:Image;
      
      private var _embed_mxml_autoevony_gui_images_honor_png_2025036117:Class;
      
      private var _embed_mxml_autoevony_gui_images_ranking_png_445787723:Class;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _975146800gameCoins:String;
      
      private var _905826493server:String;
      
      private var _1276224445prestige:String;
      
      mx_internal var _bindings:Array;
      
      private var _1376863085roleImg:int;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public var _TopInfo_Label10:Label;
      
      private var _978111542ranking:String;
      
      private var _110371416title:String;
      
      public function TopInfo()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":600,
                  "height":41,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 0;
                        this.verticalGap = 0;
                        this.paddingLeft = 25;
                        this.paddingRight = 5;
                        this.paddingTop = 1;
                        this.paddingBottom = 2;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {"childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":40,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":105,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label1",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Server"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_alliance_png_1159272469};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":90,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label2",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Alliance"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_prestige_png_988543979};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":90,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label3",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Prestige"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_rank_png_1843179317};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":85,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label4",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Office"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_gameCoins_png_216677973};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":80,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label5",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Cents / Game coins"};
                                    }
                                 })]
                              };
                           }
                        })]};
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "maxWidth":690,
                           "height":2,
                           "styleName":"horizontalSeparator2pxLine"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 0;
                        this.verticalGap = 0;
                        this.paddingLeft = 25;
                        this.paddingRight = 0;
                        this.paddingTop = 1;
                        this.paddingBottom = 1;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {"childDescriptors":[new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"width":17};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_ranking_png_445787723};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":105,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label6",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Rank by Prestige"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_TopInfo_Image7"
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":90,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label7",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Alliance Role"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_honor_png_2025036117};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":90,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label8",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Honor"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_title_png_2018272843};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":85,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label9",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Title"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":23,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_autoevony_gui_images_gift_png_2082389813};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":80,
                                 "height":17,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TopInfo_Label10",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontFamily = "DejaVu Sans";
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"toolTip":"Available Packages"};
                                    }
                                 })]
                              };
                           }
                        })]};
                     }
                  })]
               };
            }
         });
         this._1569142294allianceLvLArr = new ArrayList([AllianceLv5,AllianceLv4,AllianceLv3,AllianceLv2,AllianceLv1]);
         this._embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973 = TopInfo__embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973;
         this._embed_mxml_autoevony_gui_images_alliance_png_1159272469 = TopInfo__embed_mxml_autoevony_gui_images_alliance_png_1159272469;
         this._embed_mxml_autoevony_gui_images_gameCoins_png_216677973 = TopInfo__embed_mxml_autoevony_gui_images_gameCoins_png_216677973;
         this._embed_mxml_autoevony_gui_images_gift_png_2082389813 = TopInfo__embed_mxml_autoevony_gui_images_gift_png_2082389813;
         this._embed_mxml_autoevony_gui_images_honor_png_2025036117 = TopInfo__embed_mxml_autoevony_gui_images_honor_png_2025036117;
         this._embed_mxml_autoevony_gui_images_prestige_png_988543979 = TopInfo__embed_mxml_autoevony_gui_images_prestige_png_988543979;
         this._embed_mxml_autoevony_gui_images_rank_png_1843179317 = TopInfo__embed_mxml_autoevony_gui_images_rank_png_1843179317;
         this._embed_mxml_autoevony_gui_images_ranking_png_445787723 = TopInfo__embed_mxml_autoevony_gui_images_ranking_png_445787723;
         this._embed_mxml_autoevony_gui_images_title_png_2018272843 = TopInfo__embed_mxml_autoevony_gui_images_title_png_2018272843;
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.horizontalAlign = "center";
            this.horizontalGap = 0;
            this.verticalGap = 0;
            this.paddingLeft = 0;
            this.paddingRight = 0;
            this.paddingTop = 0;
            this.paddingBottom = 0;
         };
         this.width = 600;
         this.height = 41;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TopInfo._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      private function get allianceLvLArr() : ArrayList
      {
         return this._1569142294allianceLvLArr;
      }
      
      [Bindable(event="propertyChange")]
      public function get gameCoins() : String
      {
         return this._975146800gameCoins;
      }
      
      [Bindable(event="propertyChange")]
      public function get ranking() : String
      {
         return this._978111542ranking;
      }
      
      [Bindable(event="propertyChange")]
      public function get alliance() : String
      {
         return this._1806944311alliance;
      }
      
      private function set allianceLvLArr(param1:ArrayList) : void
      {
         var _loc2_:Object = this._1569142294allianceLvLArr;
         if(_loc2_ !== param1)
         {
            this._1569142294allianceLvLArr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceLvLArr",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gift() : String
      {
         return this._3172656gift;
      }
      
      [Bindable(event="propertyChange")]
      public function get server() : String
      {
         return this._905826493server;
      }
      
      [Bindable(event="propertyChange")]
      public function get title() : String
      {
         return this._110371416title;
      }
      
      [Bindable(event="propertyChange")]
      public function get prestige() : String
      {
         return this._1276224445prestige;
      }
      
      public function set gameCoins(param1:String) : void
      {
         var _loc2_:Object = this._975146800gameCoins;
         if(_loc2_ !== param1)
         {
            this._975146800gameCoins = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gameCoins",_loc2_,param1));
         }
      }
      
      public function set gift(param1:String) : void
      {
         var _loc2_:Object = this._3172656gift;
         if(_loc2_ !== param1)
         {
            this._3172656gift = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gift",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get honor() : String
      {
         return this._99462250honor;
      }
      
      public function set ranking(param1:String) : void
      {
         var _loc2_:Object = this._978111542ranking;
         if(_loc2_ !== param1)
         {
            this._978111542ranking = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ranking",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get roleImg() : int
      {
         return this._1376863085roleImg;
      }
      
      public function set alliance(param1:String) : void
      {
         var _loc2_:Object = this._1806944311alliance;
         if(_loc2_ !== param1)
         {
            this._1806944311alliance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alliance",_loc2_,param1));
         }
      }
      
      public function set office(param1:String) : void
      {
         var _loc2_:Object = this._1019789636office;
         if(_loc2_ !== param1)
         {
            this._1019789636office = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"office",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get role() : String
      {
         return this._3506294role;
      }
      
      public function set prestige(param1:String) : void
      {
         var _loc2_:Object = this._1276224445prestige;
         if(_loc2_ !== param1)
         {
            this._1276224445prestige = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prestige",_loc2_,param1));
         }
      }
      
      public function set server(param1:String) : void
      {
         var _loc2_:Object = this._905826493server;
         if(_loc2_ !== param1)
         {
            this._905826493server = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"server",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:TopInfo = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._TopInfo_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_TopInfoWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      public function set title(param1:String) : void
      {
         var _loc2_:Object = this._110371416title;
         if(_loc2_ !== param1)
         {
            this._110371416title = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"title",_loc2_,param1));
         }
      }
      
      private function _TopInfo_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.server;
         _loc1_ = this.alliance;
         _loc1_ = this.prestige;
         _loc1_ = this.office;
         _loc1_ = this.gameCoins;
         _loc1_ = this.ranking;
         _loc1_ = this.allianceLvLArr.getItemAt(this.roleImg);
         _loc1_ = this.role;
         _loc1_ = this.honor;
         _loc1_ = this.title;
         _loc1_ = this.gift;
      }
      
      [Bindable(event="propertyChange")]
      public function get office() : String
      {
         return this._1019789636office;
      }
      
      public function set honor(param1:String) : void
      {
         var _loc2_:Object = this._99462250honor;
         if(_loc2_ !== param1)
         {
            this._99462250honor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"honor",_loc2_,param1));
         }
      }
      
      public function set roleImg(param1:int) : void
      {
         var _loc2_:Object = this._1376863085roleImg;
         if(_loc2_ !== param1)
         {
            this._1376863085roleImg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"roleImg",_loc2_,param1));
         }
      }
      
      private function _TopInfo_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.server;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label1.text = param1;
         },"_TopInfo_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.alliance;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label2.text = param1;
         },"_TopInfo_Label2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.prestige;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label3.text = param1;
         },"_TopInfo_Label3.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.office;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label4.text = param1;
         },"_TopInfo_Label4.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.gameCoins;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label5.text = param1;
         },"_TopInfo_Label5.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.ranking;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label6.text = param1;
         },"_TopInfo_Label6.text");
         result[5] = binding;
         binding = new Binding(this,function():Object
         {
            return this.allianceLvLArr.getItemAt(this.roleImg);
         },function(param1:Object):void
         {
            _TopInfo_Image7.source = param1;
         },"_TopInfo_Image7.source");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.role;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label7.text = param1;
         },"_TopInfo_Label7.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.honor;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label8.text = param1;
         },"_TopInfo_Label8.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.title;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label9.text = param1;
         },"_TopInfo_Label9.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.gift;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TopInfo_Label10.text = param1;
         },"_TopInfo_Label10.text");
         result[10] = binding;
         return result;
      }
      
      public function set role(param1:String) : void
      {
         var _loc2_:Object = this._3506294role;
         if(_loc2_ !== param1)
         {
            this._3506294role = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"role",_loc2_,param1));
         }
      }
   }
}

