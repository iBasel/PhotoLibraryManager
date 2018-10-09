using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class PhotoLibraryManager : MonoBehaviour {

#if (UNITY_IPHONE && !UNITY_EDITOR)
	[DllImport("__Internal")]
	private static extern void PhotoLibraryManager_Init();

	[DllImport("__Internal")]
	private static extern void PhotoLibraryManager_RequestAuthorization();

	[DllImport("__Internal")]
	private static extern void PhotoLibraryManager_SavePhoto(string path);

	[DllImport("__Internal")]
	private static extern void PhotoLibraryManager_SaveVideo(string path);
#endif

	public static PhotoLibraryManager Instance;

	// Use this for initialization
	void Start () {
		Instance = this;

#if (UNITY_IPHONE && !UNITY_EDITOR)
		PhotoLibraryManager_Init();
		PhotoLibraryManager_RequestAuthorization();
#endif

	}

	public void SaveVideo(string path)
	{
#if (UNITY_IPHONE && !UNITY_EDITOR)
		PhotoLibraryManager_SaveVideo(path);
#endif
	}

	public void SavePhoto(string path)
	{
#if (UNITY_IPHONE && !UNITY_EDITOR)
		PhotoLibraryManager_SavePhoto(path);
#endif
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
