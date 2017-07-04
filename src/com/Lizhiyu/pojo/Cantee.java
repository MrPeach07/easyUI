package com.Lizhiyu.pojo;

/**
 * Created by Administrator on 2017/7/4.
 */
public class Cantee {

    private int people_count;

    public Cantee() {
        super();
    }

    public int getPeople_count() {
        return people_count;
    }

    public void setPeople_count(int people_count) {
        this.people_count = people_count;
    }

    public Cantee(int people_count) {
        super();
        this.people_count = people_count;

    }

    @Override
    public String toString() {
        return "data [head_count=" + people_count + "]";
    }
}
