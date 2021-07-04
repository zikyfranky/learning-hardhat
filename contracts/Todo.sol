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

    mapping(address=>Task[]) usersTasks;

    /** 
    * @notice function responsible for the creation of tasks
    * @param _task The task to be created
    * @param _owner  The author of the task
    */

    function createTask(string memory _task, string memory _owner) public {
        Task memory task_;
        task_.id = usersTasks[msg.sender].length;
        task_.date = block.timestamp;
        task_.owner = _owner;
        task_.task = _task;
        // isDone value is false by default 

        usersTasks[msg.sender].push(task_);
    }
}