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
    * @notice Function responsible for the creation of tasks
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

    
    /** 
    * @notice Function responsible for the fetching a user's specific task by id
    * @param _user The creator of the task
    * @param _id The index of the task
    */

    function getSingleUserTask(address _user, uint256 _id) public view returns(Task memory task_) {
        task_ = usersTasks[_user][_id];
        require(task_.date != 0 && task_.date <= block.timestamp, "Task with id doesn't exists");
    }
    
    /** 
    * @notice Function responsible for the fetching all user's
    * @param _user The creator of the tasks
    */

    function getUserTasks(address _user) public view returns(Task[] memory tasks_) {
        tasks_ = usersTasks[_user];
    }
}