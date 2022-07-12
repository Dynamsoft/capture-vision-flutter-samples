package com.dynamsoft.dcv.flutter.handles;

public class DynamsoftToolsManager {

	private volatile static DynamsoftToolsManager manager;

	private DynamsoftToolsManager() {
	}

	public static DynamsoftToolsManager manager() {
		if (manager == null) {
			synchronized (DynamsoftToolsManager.class) {
				if (manager == null) {
					manager = new DynamsoftToolsManager();
				}
			}
		}
		return manager;
	}
}

