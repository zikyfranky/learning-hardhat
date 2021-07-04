// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

contract Todo {

    struct Task {
        uint id;
        bool isDone;
        uint date;
        string owner;
        string task;
    }

    Task[] tasks;

    function createTask(string memory _task, string memory _owner) public {
        Task memory task_;
        task_.id = tasks.length;
        task_.date = block.timestamp;
        task_.owner = _owner;
        task_.task = _task;
        // isDone value is false by default 

        tasks.push(task_);
    }
}