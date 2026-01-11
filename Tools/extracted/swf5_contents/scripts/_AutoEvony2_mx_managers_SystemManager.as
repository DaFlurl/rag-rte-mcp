package
{
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import mx.core.EmbeddedFontRegistry;
   import mx.core.FlexVersion;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.managers.SystemManager;
   
   public class _AutoEvony2_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory
   {
      private var _preloadedRSLs:Dictionary;
      
      public function _AutoEvony2_mx_managers_SystemManager()
      {
         FlexVersion.compatibilityVersionString = "3.0.0";
         super();
      }
      
      override public function create(... rest) : Object
      {
         if(rest.length > 0 && !(rest[0] is String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0 ? "AutoEvony2" : String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object = new _loc3_();
         if(_loc4_ is IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory = this;
         }
         if(rest.length == 0)
         {
            EmbeddedFontRegistry.registerFonts(this.info()["fonts"],this);
         }
         return _loc4_;
      }
      
      override public function allowInsecureDomain(... rest) : void
      {
         var _loc2_:Object = null;
         Security.allowInsecureDomain(rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(Boolean(_loc2_.content) && "allowInsecureDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowInsecureDomainInRSL"](rest);
            }
         }
      }
      
      override public function info() : Object
      {
         return {
            "backgroundColor":"0x636467",
            "backgroundGradientAlphas":"[0, 0]",
            "compiledLocales":["en_US"],
            "compiledResourceBundleNames":["SharedResources","collections","containers","controls","core","effects","formatters","logging","messaging","rpc","skins","styles"],
            "creationComplete":"{this.init();return;}",
            "currentDomain":ApplicationDomain.currentDomain,
            "fonts":{"DejaVu Sans":{
               "regular":true,
               "bold":true,
               "italic":true,
               "boldItalic":true
            }},
            "horizontalGap":"0",
            "layout":"absolute",
            "mainClassName":"AutoEvony2",
            "minHeight":"550",
            "minWidth":"710",
            "mixins":["_AutoEvony2_FlexInit","_richTextEditorTextAreaStyleStyle","_DividedBoxStyle","_alertButtonStyleStyle","_SWFLoaderStyle","_FormStyle","_textAreaVScrollBarStyleStyle","_headerDateTextStyle","_VDividedBoxStyle","_globalStyle","_ListBaseStyle","_todayStyleStyle","_TabBarStyle","_windowStylesStyle","_ApplicationStyle","_ToolTipStyle","_FormItemLabelStyle","_ButtonBarButtonStyle","_CursorManagerStyle","_opaquePanelStyle","_TextInputStyle","_errorTipStyle","_dateFieldPopupStyle","_FormItemStyle","_ComboBoxStyle","_TabStyle","_dataGridStylesStyle","_DataGridStyle","_popUpMenuStyle","_headerDragProxyStyleStyle","_activeTabStyleStyle","_DragManagerStyle","_ContainerStyle","_TextAreaStyle","_windowStatusStyle","_ScrollBarStyle","_swatchPanelTextFieldStyle","_ButtonBarStyle","_textAreaHScrollBarStyleStyle","_plainStyle","_activeButtonStyleStyle","_advancedDataGridStylesStyle","_CheckBoxStyle","_comboDropdownStyle","_ButtonStyle","_HDividedBoxStyle","_DataGridItemRendererStyle","_weekDayStyleStyle"
            ,"_linkButtonStyleStyle","_autoevony_gui_controls_popup_PopUpWinBaseWatcherSetupUtil","_autoevony_gui_AlertWinWatcherSetupUtil","_autoevony_gui_newarmy_TroopInputWatcherSetupUtil","_autoevony_gui_info_Alliance_AllianceInviteMemberWinWatcherSetupUtil","_autoevony_gui_info_Alliance_CheckApplyWinWatcherSetupUtil","_autoevony_gui_LoginScreenWatcherSetupUtil","_autoevony_gui_info_Mail_MailsViewWatcherSetupUtil","_autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil","_autoevony_gui_info_Reports_ReportViewWatcherSetupUtil","_autoevony_gui_TopInfoWatcherSetupUtil","_autoevony_gui_MainScreenWatcherSetupUtil","_autoevony_gui_ChatPanelWatcherSetupUtil","_autoevony_gui_SnippetsWatcherSetupUtil","_autoevony_gui_CityPanelWatcherSetupUtil","_autoevony_gui_AccountInfoWatcherSetupUtil","_autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil","_autoevony_gui_info_Items_ItemInfoWatcherSetupUtil","_autoevony_gui_info_HistoricalHeroesWatcherSetupUtil","_autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil"
            ,"_autoevony_gui_info_LegendaryHeroWatcherSetupUtil","_autoevony_gui_info_Alliance_AllianceListWatcherSetupUtil","_autoevony_gui_info_Alliance_DiplomacyWatcherSetupUtil","_autoevony_gui_info_Alliance_WarReportWatcherSetupUtil","_autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil","_autoevony_gui_info_Alliance_EventsWatcherSetupUtil","_autoevony_gui_info_Reports_ReportsWatcherSetupUtil","_autoevony_gui_info_Mail_MailBoxWatcherSetupUtil","_autoevony_gui_info_Mail_ComposeWatcherSetupUtil","_autoevony_gui_info_Stats_HeroesWatcherSetupUtil","_autoevony_gui_info_Stats_CitiesWatcherSetupUtil","_autoevony_gui_info_Stats_PlayersWatcherSetupUtil","_autoevony_gui_info_Stats_AlliancesWatcherSetupUtil","_autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil","_autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil","_autoevony_gui_heroview_HeroViewWinWatcherSetupUtil","_autoevony_gui_ArmyDetailsWinWatcherSetupUtil","_autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil","_autoevony_gui_heroview_ChooseHeroItemWinWatcherSetupUtil"
            ,"_autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil","_autoevony_gui_heroview_BuffsArray_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_FormatPopulation_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_FormatRank_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_FormatRanking_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_FormatPrestige_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_FormatHonor_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_Alliance_CancelDiploBtn_inlineComponent0WatcherSetupUtil","_autoevony_gui_info_Alliance_Info_inlineComponent1WatcherSetupUtil","_autoevony_gui_newarmy_NewArmy_inlineComponent0WatcherSetupUtil","_autoevony_gui_CityPanel_inlineComponent2_1WatcherSetupUtil","_autoevony_gui_CityPanel_inlineComponent2_2WatcherSetupUtil","_autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil","_autoevony_gui_CityPanel_inlineComponent4WatcherSetupUtil","_autoevony_gui_CityPanel_inlineComponent3WatcherSetupUtil","_autoevony_gui_CityPanel_inlineComponent0WatcherSetupUtil"
            ,"_autoevony_gui_info_Alliance_CheckOutBtnWatcherSetupUtil"],
            "modalTransparency":"0.3",
            "modalTransparencyBlur":"1",
            "modalTransparencyColor":"0x202225",
            "modalTransparencyDuration":"100",
            "paddingBottom":"0",
            "paddingLeft":"0",
            "paddingRight":"0",
            "paddingTop":"0",
            "pageTitle":"RE for Age II",
            "verticalGap":"0"
         };
      }
      
      override public function get preloadedRSLs() : Dictionary
      {
         if(this._preloadedRSLs == null)
         {
            this._preloadedRSLs = new Dictionary(true);
         }
         return this._preloadedRSLs;
      }
      
      override public function allowDomain(... rest) : void
      {
         var _loc2_:Object = null;
         Security.allowDomain(rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(Boolean(_loc2_.content) && "allowDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowDomainInRSL"](rest);
            }
         }
      }
   }
}

