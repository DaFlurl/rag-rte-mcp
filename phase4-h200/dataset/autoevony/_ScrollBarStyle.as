// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ScrollBarStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.ScrollTrackSkin;
    import mx.skins.halo.ScrollArrowSkin;
    import mx.skins.halo.ScrollThumbSkin;
    import mx.core.IFlexModuleFactory;

    public class _ScrollBarStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ScrollBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ScrollBar", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.thumbOffset = 0;
                    this.paddingTop = 0;
                    this.borderColor = 12040892;
                    this.trackColors = [9738651, 0xE7E7E7];
                    this.trackSkin = ScrollTrackSkin;
                    this.downArrowSkin = ScrollArrowSkin;
                    this.cornerRadius = 4;
                    this.upArrowSkin = ScrollArrowSkin;
                    this.paddingLeft = 0;
                    this.paddingBottom = 0;
                    this.thumbSkin = ScrollThumbSkin;
                    this.paddingRight = 0;
                };
            };
        }


    }
}//package 

