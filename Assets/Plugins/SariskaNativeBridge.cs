using UnityEngine;
using System;
using System.Runtime.InteropServices;

namespace Plugins.SariskaNativeBridge
{
    public static class SariskaNativeBridge
    {
        private const string GAME_OBJECT_NAME = "PluginBridge";
        private static GameObject gameObject;

        //iOS only variables
#if UNITY_IOS
        [DllImport("__Internal")]
#endif
        private static extern string initializeSariskaMediaTransport(); //External native method

        static SariskaNativeBridge()
        {
            // Create Game Object to allow sending messages from Java or Objective C to Unity
            gameObject = new GameObject();

            // Object name must match UnitySendMessage call in Java or Objective C
            gameObject.name = GAME_OBJECT_NAME;

            // Do not destroy when loading a new scene
            UnityEngine.Object.DontDestroyOnLoad(gameObject);

        }

        public static void initSariska()
        {
            initializeSariskaMediaTransport();
        }

    }

   
}