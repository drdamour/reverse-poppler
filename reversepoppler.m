#include "..\..\lib\std.mi"


Function openSidecar();
Function closeSidecar();

Global Boolean found;
Global Boolean Shifting;

Global Button poppler;
Global Layout L;
Global Layout MainL;
Global Group sidecar;



System.onScriptLoaded() {

	//Get Main Container's Layout
	MainL =	getContainer("Main").getLayout("Normal");

	//L = getContainer("pledit").getLayout("normal");
	//poppler = L.findObject("pledit.poppler");
	//sidecar = L.findObject("pledit.sidecar.layout.pane");
	//if(sidecar == NULL) sidecar = L.findObject("pledit.right");


	int containers = getNumContainers();	//get total number of containers
	int ccount = 0;				//interator of containers
	while(ccount < containers){			//iterate through the containers

		container c = enumContainer(ccount);	//get container

		int layouts = c.getNumLayouts();	//get number of layouts
		int  lcount = 0;			//iterator of layouts
		while(lcount < layouts){		//iterate through layouts

			L = c.enumLayout(lcount);	//get Layer

			poppler = L.findObject("pledit.poppler");	//try to find poppler

			if (poppler != NULL){		//if it's found
				lcount = layouts+1;		//kill this loop
				ccount = containers+1;		//kill upper loop
				sidecar = L.findObject("pledit.sidecar.layout.pane");	//find sidecar
				if(sidecar == NULL) sidecar = L.findObject("pledit.right");
			}
			lcount++;
		}
		ccount++;		
	}

 
	if(poppler == NULL){//never found it
		poppler = getContainer("rpbackup").getLayout("normal").findobject("rpback.button");
		found = false;

	}
	else{
		found = true;


		//reverse arrow direction
		if (sidecar.isVisible()){
			poppler.setXmlParam("image", "wasabi.button.label.arrow.left");
		}
		else {
			poppler.setXmlParam("image", "wasabi.button.label.arrow.right");
		}
		

		//Set arrow direction in case of PopplerR2
		string attach = getPrivateString("pledit.poppler", "attach", "right");
		if (attach != "right"){
			if (attach == "left"){
				if (sidecar.isVisible()){
					poppler.setXmlParam("image", "wasabi.button.label.arrow.right");
				}
				else {
					poppler.setXmlParam("image", "wasabi.button.label.arrow.left");
				}
			}
			else if (attach == "top"){
				if (sidecar.isVisible()){
					poppler.setXmlParam("image", "wasabi.button.label.arrow.down");
				}
				else {
					poppler.setXmlParam("image", "wasabi.button.label.arrow.up");
				}
			}
			else if (attach == "bottom"){
				if (sidecar.isVisible()){
					poppler.setXmlParam("image", "wasabi.button.label.arrow.up");
				}
				else {
					poppler.setXmlParam("image", "wasabi.button.label.arrow.down");
				}
			}


		}
	}
}



openSidecar() {

	string attach = getPrivateString("pledit.poppler", "attach", "none");
	int offset;

	if (attach == "none") {//Poppler isn't present
		offset = 130;
		poppler.setXmlParam("image", "wasabi.button.label.arrow.left");

		if (MainL.getLeft() == (L.getLeft() + L.getWidth())){
			L.resize(L.getLeft()-offset, L.getTop(), L.getWidth() + offset, L.getHeight());
		}
		else {
			L.resize(L.getLeft(), L.getTop(), L.getWidth() + offset, L.getHeight());
		}

	}
	
	else if (attach == "right"){

		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarw", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.left");


		if (MainL.getLeft() == (L.getLeft() + L.getWidth())){
			L.resize(L.getLeft()-offset, L.getTop(), L.getWidth() + offset, L.getHeight());
		}
		else {
			L.resize(L.getLeft(), L.getTop(), L.getWidth() + offset, L.getHeight());
	
		}

	}
	else if (attach == "left"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarw", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.right");

		if (MainL.getLeft() + MainL.getWidth() == L.getLeft()){
			L.resize(L.getLeft(), L.getTop(), L.getWidth() + offset, L.getHeight());
		}
		else {
			L.resize(L.getLeft()-offset, L.getTop(), L.getWidth() + offset, L.getHeight());
		}
		

	}
	else if (attach == "top"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarh", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.down");

		if (MainL.getTop() + MainL.getHeight()  == L.getTop() ){
			L.resize(L.getLeft(), L.getTop(), L.getWidth(), L.getHeight() + offset);
		}
		else {
			L.resize(L.getLeft(), L.getTop() - offset, L.getWidth(), L.getHeight()+offset);
		}
	}
	else if (attach == "bottom"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarh", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.up");

		if (MainL.getTop() == L.getTop() + L.getHeight() ){
			L.resize(L.getLeft(), L.getTop()-offset, L.getWidth(), L.getHeight() + offset);
		}
		else {
			L.resize(L.getLeft(), L.getTop(), L.getWidth(), L.getHeight()+offset);
		}


	}


}


CloseSidecar(){
	string attach = getPrivateString("pledit.poppler", "attach", "none");
	int offset;

	if (attach == "none") {//Poppler isn't present
		offset = 130;
		poppler.setXmlParam("image", "wasabi.button.label.arrow.right");

		if (MainL.getLeft() == (L.getLeft() + L.getWidth())){
			L.resize(L.getLeft()+offset, L.getTop(), L.getWidth() - offset, L.getHeight());
		}
		else {
			L.resize(L.getLeft(), L.getTop(), L.getWidth() - offset, L.getHeight());
		}

	}
	
	else if (attach == "right"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarw", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.right");

		if (MainL.getLeft() == (L.getLeft() + L.getWidth())){
			L.resize(L.getLeft()+offset, L.getTop(), L.getWidth() - offset, L.getHeight());
		}
		else {
			L.resize(L.getLeft(), L.getTop(), L.getWidth() - offset, L.getHeight());
		}

	}
	else if (attach == "left"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarw", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.left");

		if (MainL.getLeft() + MainL.getWidth() == L.getLeft()){
			L.resize(L.getLeft(), L.getTop(), L.getWidth() - offset, L.getHeight());
		}
		else {
			L.resize(L.getLeft()+offset, L.getTop(), L.getWidth() - offset, L.getHeight());
		}
	}

	else if (attach == "top"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarh", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.up");

		if (MainL.getTop() + MainL.getHeight() == L.getTop() ){
			L.resize(L.getLeft(), L.getTop(), L.getWidth(), L.getHeight() - offset);
		}
		else {
			L.resize(L.getLeft(), L.getTop() + offset, L.getWidth(), L.getHeight()-offset);
		}
	}
	else if (attach == "bottom"){	
		offset = stringToInteger(getPrivateString("pledit.poppler", "sidecarh", "0"));
		poppler.setXmlParam("image", "wasabi.button.label.arrow.down");

		if (MainL.getTop() == L.getTop() + L.getHeight() ){
			L.resize(L.getLeft(), L.getTop()+offset, L.getWidth(), L.getHeight() - offset);
		}
		else {
			L.resize(L.getLeft(), L.getTop(), L.getWidth(), L.getHeight()-offset);
		}


	}

}




poppler.onLeftButtonDown(int x, int y) {
	if (isKeyDown(VK_SHIFT)){
		shifting = true;
	}
	else{
		shifting = false;
	}

}





poppler.onLeftButtonUp(int x, int y) {
	if (shifting || !found){
	}
	else {
		
		if (sidecar.isVisible()) {
			openSidecar();
		} 
		else {
			closeSidecar();
		}	
	}
}