// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

contract Todo {

    struct Task {
        uint id;
        bool isDone;
        uint date;
        string owner;
        string task;
    }

    mapping(address=>Task[]) public usersTasks;

    modifier taskExists(address _user, uint256 _id) {
        uint256 uTaskLength = usersTasks[_user].length;
        require(_id < uTaskLength, "Index doesn't exists");
        _;
    }

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

    function getSingleUserTask(address _user, uint256 _id) public view taskExists(_user, _id) returns(Task memory task_) {
        task_ = usersTasks[_user][_id];
    }
    
    /** 
    * @notice Function responsible for the fetching all user's
    * @param _user The creator of the tasks
    */

    function getUserTasks(address _user) public view returns(Task[] memory tasks_) {
        tasks_ = usersTasks[_user];
    }
    
    /** 
    * @notice Function responsible for deleting user's task by id
    * @param _id index of array to be deleted
    */

    function removeUserTask(uint256 _id) public taskExists(msg.sender, _id) {
        // Get last element index (indices start from 0)
        uint256 lastIndex = usersTasks[msg.sender].length - 1;
        // Fetch the task and store in a variable
        Task memory task = usersTasks[msg.sender][lastIndex];
        // Update  task id to match deleted id
        task.id = _id;
        // Replace task to be deleted wit the last element
        usersTasks[msg.sender][_id] = task;

        // Delete last element
        usersTasks[msg.sender].pop();
    }

    
    /** 
    * @notice Function responsible for editing/modifying a specific task
    * @param _id index of task to be modified
    * @param _task The updated task
    * @param _owner  The Updated author
    * @param _date  The Updated date
    * @param _isDone  The Updated status
    */

    function updateTask(uint256 _id, string memory _task, string memory _owner, uint256 _date, bool _isDone) public taskExists(msg.sender, _id) {
        Task memory task_ = usersTasks[msg.sender][_id];
        task_.task = _task;
        task_.owner = _owner;
        task_.date = _date;
        task_.isDone = _isDone;

        usersTasks[msg.sender][_id] = task_;
    }
    
    /** 
    * @notice Function responsible for editing/modifying a specific task's task
    * @param _id index of task to be modified
    * @param _task The updated task
    */

    function updateTaskText(uint256 _id, string memory _task) public taskExists(msg.sender, _id) {
        usersTasks[msg.sender][_id].task = _task;
    }
    
    /** 
    * @notice Function responsible for editing/modifying a specific task's owner
    * @param _id index of task to be modified
    * @param _owner The updated owner
    */

    function updateTaskOwner(uint256 _id, string memory _owner) public taskExists(msg.sender, _id) {
        usersTasks[msg.sender][_id].owner = _owner;
    }
    
    /** 
    * @notice Function responsible for editing/modifying a specific task's date
    * @param _id index of task to be modified
    * @param _date The updated date
    */

    function updateTaskDate(uint256 _id, uint256 _date) public taskExists(msg.sender, _id) {
        usersTasks[msg.sender][_id].date = _date;
    }
    
    /** 
    * @notice Function responsible for editing/modifying a specific task's isDone
    * @param _id index of task to be modified
    * @param _isDone The updated isDone
    */

    function updateTaskStatus(uint256 _id, bool _isDone) public taskExists(msg.sender, _id) {
        usersTasks[msg.sender][_id].isDone = _isDone;
    }
    
    /** 
    * @notice Function responsible for marking task as done
    * @param _id index of task to be modified
    */

    function markTaskAsComplete(uint256 _id) public taskExists(msg.sender, _id) {
        usersTasks[msg.sender][_id].isDone = true;
    }
    
    /** 
    * @notice Function responsible for marking task as undone
    * @param _id index of task to be modified
    */

    function markTaskAsIncomplete(uint256 _id) public taskExists(msg.sender, _id) {
        usersTasks[msg.sender][_id].isDone = false;
    }
}