// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_DataGridStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.DataGridSortArrow;
    import mx.skins.halo.DataGridColumnDropIndicator;
    import mx.skins.halo.DataGridColumnResizeSkin;
    import mx.skins.halo.DataGridHeaderSeparator;
    import mx.skins.halo.DataGridHeaderBackgroundSkin;
    import mx.core.IFlexModuleFactory;

    public class _DataGridStyle 
    {

        private static var _embed_css_Assets_swf_cursorStretch_1897339043:Class = _DataGridStyle__embed_css_Assets_swf_cursorStretch_1897339043;


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DataGrid");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DataGrid", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.sortArrowSkin = DataGridSortArrow;
                    this.columnDropIndicatorSkin = DataGridColumnDropIndicator;
                    this.columnResizeSkin = DataGridColumnResizeSkin;
                    this.stretchCursor = _embed_css_Assets_swf_cursorStretch_1897339043;
                    this.alternatingItemColors = [0xF7F7F7, 0xFFFFFF];
                    this.headerStyleName = "dataGridStyles";
                    this.headerSeparatorSkin = DataGridHeaderSeparator;
                    this.headerBackgroundSkin = DataGridHeaderBackgroundSkin;
                    this.headerColors = [0xFFFFFF, 0xE6E6E6];
                    this.headerDragProxyStyleName = "headerDragProxyStyle";
                    this.verticalGridLineColor = 0xCCCCCC;
                };
            };
        }


    }
}//package 

