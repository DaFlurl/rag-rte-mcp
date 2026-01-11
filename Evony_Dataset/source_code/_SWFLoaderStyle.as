// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_SWFLoaderStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.BrokenImageBorderSkin;
    import mx.core.IFlexModuleFactory;

    public class _SWFLoaderStyle 
    {

        private static var _embed_css_Assets_swf___brokenImage_562868570:Class = _SWFLoaderStyle__embed_css_Assets_swf___brokenImage_562868570;


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("SWFLoader");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SWFLoader", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.borderStyle = "none";
                    this.brokenImageSkin = _embed_css_Assets_swf___brokenImage_562868570;
                    this.brokenImageBorderSkin = BrokenImageBorderSkin;
                };
            };
        }


    }
}//package 

