using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Base : MonoBehaviour 
{
    public int a = 1;
    public int aaa = 1;

    void Start()
    {
        Debug.Log(3);
        Debug.Log(Reduce(5, 2));
        Debug.Log(aaa);
    }

    public int Show()
    {
        Debug.Log(a);
        a = a + 1;
        return a;
    }

    public int Add(int b, int c)
    {
        return b + c;
    }

    public int Reduce(int b, int c)
    {
        aaa = b - c;
        return aaa;
    }
}
