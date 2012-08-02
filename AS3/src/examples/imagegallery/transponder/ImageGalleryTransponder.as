package examples.imagegallery.transponder 
{
	import examples.imagegallery.ImageGallery;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ImageGalleryTransponder extends Transponder 
	{
		
		public function ImageGalleryTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			
			transmit(ImageGallery.INIT);
		}
	}

}