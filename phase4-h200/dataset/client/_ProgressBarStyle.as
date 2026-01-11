// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_ProgressBarStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.skins.halo.ProgressMaskSkin;
    import mx.skins.halo.ProgressTrackSkin;
    import mx.skins.halo.ProgressBarSkin;
    import mx.skins.halo.ProgressIndeterminateSkin;
    import mx.core.IFlexModuleFactory;

    public class _ProgressBarStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ProgressBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ProgressBar", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.trackColors = [0xE7E7E7, 0xFFFFFF];
                    this.fontWeight = "bold";
                    this.maskSkin = ProgressMaskSkin;
                    this.leading = 0;
                    this.trackSkin = ProgressTrackSkin;
                    this.indeterminateMoveInterval = 28;
                    this.barSkin = ProgressBarSkin;
                    this.indeterminateSkin = ProgressIndeterminateSkin;
                };
            };
        }


    }
}//package 

