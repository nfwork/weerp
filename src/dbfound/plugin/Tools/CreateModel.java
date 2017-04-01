package dbfound.plugin.Tools;

import com.nfwork.dbfound.core.DBFoundConfig;
import com.nfwork.dbfound.model.tools.ModelTool;

public class CreateModel {
	
	public static void main(String[] args) {
		DBFoundConfig.setConfigFilePath("${@projectRoot}/WEB-INF/dbfound-conf.xml");
		ModelTool.generateModel(null, "gl_book_set", "book_set_id");
	}

}
